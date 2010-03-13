//
//  Compiler.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/1/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "Compiler.h"
#import "OutputParser.h"
#import "OakTextViewProxy.h"

static NSString* compilerPath;

@implementation Compiler

#pragma mark -
#pragma mark Init Methods


+ (void)initialize
{
	compilerPath = [[NSBundle pathForResource: @"fcshctl-mxmlc" ofType: nil inDirectory: [[NSBundle bundleForClass: [self class]] bundlePath]] copy];
}

- (id)init
{
	if (self = [super init])
	{
		// Create the output parser.
		// TODO: Move parser to CompilerController.
		parser = [[OutputParser alloc] init];
	}
	return self;
}

-(void)dealloc
{
	if (task != nil)
		[task release];

	[parser release];
	[super dealloc];
}

#pragma mark -
#pragma mark Public Methods
- (void)compile:(NSString*)aFilePath
{
	// TODO: stop task if it is running currently.
	if (task != nil)
	{
		if ([task isRunning])
			[task terminate];

		[task release];
		task = nil;
	}
	
	// Remove the fcshctl log file, if it exists.
	if ([[NSFileManager defaultManager] isReadableFileAtPath: @"/tmp/fcshctl_screen_log"])
	    [[NSFileManager defaultManager] removeFileAtPath: @"/tmp/fcshctl_screen_log" handler: nil];
	
	// Get the target file.
	NSString* sourcePath = aFilePath;
	
	// Create a task to run the compiler in the background.
	task = [[NSTask alloc] init];
 	[task setLaunchPath: compilerPath];

	// Set the arguments for the compiler.
	NSArray* args = [NSArray arrayWithObjects: @"mxmlc", sourcePath, nil];
	[task setArguments: args];

	// Create a pipe to capture the output.
	NSPipe* outputPipe = [NSPipe pipe];
	[task setStandardOutput: outputPipe];

	// Get the output pipe's file handle.
	NSFileHandle* outputHandle = [outputPipe fileHandleForReading];

	// Add an observer to monitor the file handle.
	[[NSNotificationCenter defaultCenter] addObserver: self 
		selector: @selector(outputHandleNotificationHandler:) 
		name: NSFileHandleReadCompletionNotification 
		object: outputHandle
	];

	[outputHandle readInBackgroundAndNotify];
	[task launch];

	// Notify observers that compile started.
	[[NSNotificationCenter defaultCenter] postNotificationName: @"start" object: nil];
	NSLog(@"Compiling %@...", sourcePath);
}

#pragma mark -
#pragma mark Notification Handlers

- (void)outputHandleNotificationHandler:(NSNotification*)notification
{
	NSData* data = [[notification userInfo] objectForKey:NSFileHandleNotificationDataItem];
	NSFileHandle* handle = [notification object];

	if ([data length] > 0)
	{
		NSString* str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
		[handle readInBackgroundAndNotify];

		[parser addToBuffer: str];
		[parser parse];

		// Notify observers of the output.
		[[NSNotificationCenter defaultCenter] postNotificationName: @"output" object: str];
	}
	else
	{
		[[NSNotificationCenter defaultCenter] removeObserver: self 
			name: NSFileHandleReadCompletionNotification 
			object: handle
		];

		[parser clearBuffer];
		[task release];
		task = nil;

		// Notify observers that compile completed.
		[[NSNotificationCenter defaultCenter] postNotificationName: @"complete" object: nil];
		NSLog(@"Compile Complete.");
	}
}

@end
