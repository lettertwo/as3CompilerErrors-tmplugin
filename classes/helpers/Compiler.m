//
//  Compiler.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/1/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "Compiler.h"
#import "OutputParser.h"

@implementation Compiler
@synthesize compilerPath;

- (id)init
{
	NSString* defaultCompilerPath = [NSBundle pathForResource: @"fcshctl-mxmlc" ofType: nil 
		inDirectory: [[NSBundle bundleForClass: [self class]] bundlePath]];

	return [self initWithCompilerPath: defaultCompilerPath];
}

- (id)initWithCompilerPath:(NSString*)path
{
	if ([super init])
		compilerPath = path;

	return self;
}

- (void)compile
{
	// Create a task to run the compiler in the background.
	NSTask* task = [[[NSTask alloc] init] autorelease];
	[task setLaunchPath: compilerPath];
	
	// Set the arguments for the compiler.
	NSArray* args = [NSArray arrayWithObjects:@"/Users/ede/Desktop/junk/Doc.as", nil];
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
	
	// Create the output parser.
	parser = [[OutputParser alloc] init];

	[outputHandle readInBackgroundAndNotify];
	
	[task launch];

	// Notify observers that compile started.
	[[NSNotificationCenter defaultCenter] postNotificationName: @"start" object: nil];
	NSLog(@"Compiling...");
}


- (void)outputHandleNotificationHandler:(NSNotification*)notification
{
	NSData* data = [[notification userInfo] objectForKey:NSFileHandleNotificationDataItem];
	NSFileHandle* handle = [notification object];

	if ([data length] > 0)
	{
		NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		[handle readInBackgroundAndNotify];

		[parser addToBuffer: str];
		[parser parse];

		// Notify observers of the output.
		[[NSNotificationCenter defaultCenter] postNotificationName: @"output" object: str];
//		NSLog(@"%@\n", str);
	}
	else
	{
		[[NSNotificationCenter defaultCenter] removeObserver: self 
			name: NSFileHandleReadCompletionNotification 
			object: handle
		];

		[parser clearBuffer];
		[parser release];

		// Notify observers that compile completed.
		[[NSNotificationCenter defaultCenter] postNotificationName: @"complete" object: nil];
		NSLog(@"Compile Complete.");
	}
}


-(void)dealloc
{
	[super dealloc];
}

@end
