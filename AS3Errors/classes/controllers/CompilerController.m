//
//  CompilerController.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/1/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "CompilerController.h"
#import "AutoCompilationMonitor.h"
#import "RegexKitLite.h";

static NSString* const VALID_FILE_REGEX = @"\\.as|\\.mxml$";

@interface CompilerController (Private)
- (BOOL)filePathIsCompilable:(NSString*)aFilePath;
@end

@implementation CompilerController

#pragma mark -
#pragma mark Initialization Methods

- (id)init
{
	if (self = [super init])
	{
		compiler = [[Compiler alloc] init];
		self.isAutoCompilationEnabled = YES;
	}
	
	return self;
}

- (void)dealloc
{
	[compiler release];
	[super dealloc];
}

#pragma mark -
#pragma mark Accessors

@synthesize isAutoCompilationEnabled;
@synthesize currentFilePath;

- (void)setIsAutoCompilationEnabled:(BOOL)value
{
	BOOL oldValue = self.isAutoCompilationEnabled;
	if (oldValue != value)
	{
		isAutoCompilationEnabled = value;
		
		if (value && autoCompilationMonitor == nil)
		{
			autoCompilationMonitor = [[AutoCompilationMonitor alloc] initWithCompilerController: self];
		}
		else if (autoCompilationMonitor != nil)
		{
			[autoCompilationMonitor release];
			autoCompilationMonitor = nil;
		}
	}
}


- (BOOL)isCurrentFilePathCompilable
{
	return [self filePathIsCompilable: self.currentFilePath];
}

- (NSString*)currentFilePath
{
	return currentFilePath != nil ? currentFilePath : [[NSApp mainWindow] representedFilename];
}


#pragma mark -
#pragma mark Public Methods

- (IBAction)compile:(id)sender
{
	// Start the compilation.
	if ([self isCurrentFilePathCompilable])
		[compiler compile: [self currentFilePath]];
}

- (void)compile
{
	[self compile: nil];
}


- (IBAction)toggleAutoCompilation:(id)sender
{
	self.isAutoCompilationEnabled = !self.isAutoCompilationEnabled;
}

@end


@implementation CompilerController (Private)

#pragma mark -
#pragma mark Private Methods

- (BOOL)filePathIsCompilable:(NSString*)aFilePath
{
	NSRange matchRange = [aFilePath rangeOfRegex: VALID_FILE_REGEX inRange: NSMakeRange(0, [aFilePath length])];

NSLog(@"\n\nfilepath %@ is compilable? %@", aFilePath, (matchRange.location != NSNotFound) ? @"YES" : @"NO");	

	return matchRange.location != NSNotFound;
}

@end
