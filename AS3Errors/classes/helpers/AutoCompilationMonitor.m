//
//  AutoCompilationMonitor.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/12/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "AutoCompilationMonitor.h"

@interface AutoCompilationMonitor (Private)
- (void)compileCompleteNotificationHandler:(NSNotification*)aNotification;
- (void)mainWindowChangeHandler:(NSNotification*)aNotification;
- (void)refresh;
- (void)killRefreshTimeout;
- (void)startRefreshTimeout;
@end

@implementation AutoCompilationMonitor

#pragma mark -
#pragma mark Initialization Methods

- (id)init
{
	[NSException raise:@"Invalid init" format:@"AutoCompilationMonitor must be initialized via initWithCompilerController:"];
	return nil;
}

- (id)initWithCompilerController:(id <CompilerController>)aController
{
	if (self = [super init])
	{
		compilerController = aController;
		monitorIsRunning = NO;
		
		[[NSNotificationCenter defaultCenter] addObserver: self
			selector: @selector(mainWindowChangeHandler:)
			name: NSWindowDidBecomeMainNotification 
			object: nil
		];

		[[NSNotificationCenter defaultCenter] addObserver: self
			selector: @selector(mainWindowChangeHandler:)
			name: NSWindowDidResignMainNotification 
			object: nil
		];
		
		if ([compilerController isAutoCompilationEnabled])
			[self startMonitor];
	}

	return self;
}

- (void)dealloc
{
	// TODO: Cleanup listeners, etc.
	[super dealloc];
}

#pragma mark -
#pragma mark Public Methods

- (void)startMonitor
{
// TODO: Figure out how to monitor for tab changes (as opposed to window changes).
// TODO: Only run compiler if the current doc has not already been tested in its current state.
	
	// Add an observer to detect when a compilable file is targeted.
	// [[NSNotificationCenter defaultCenter] addObserver: self
	// 	selector: @selector(mainWindowUpdateHandler:)
	// 	name: NSWindowDidUpdateNotification 
	// 	object: nil
	// ];

	monitorIsRunning = YES;
	
	[self refresh];
}

- (void)stopMonitor
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name: @"complete" object: nil];
//	[[NSNotificationCenter defaultCenter] removeObserver:self name: NSWindowDidUpdateNotification object: nil];
	[self killRefreshTimeout];
	monitorIsRunning = NO;
}

@end


@implementation AutoCompilationMonitor (Private)

#pragma mark -
#pragma mark Notification Handlers

- (void)compileCompleteNotificationHandler:(NSNotification*)aNotification
{
	if ([compilerController isAutoCompilationEnabled] && refreshTimeoutExpired)
		[self refresh];
}


// - (void)mainWindowUpdateHandler:(NSNotification*)aNotification
// {
// 	NSWindow* window = [aNotification object];
// 
// NSLog(@"WINDOW UPDATE: %@", window);
// 	[compilerController setCurrentFilePath: [[aNotification object] representedFilename]];
// 
// 	if ([compilerController isAutoCompilationEnabled] && [compilerController isCurrentFilePathCompilable] && !monitorIsRunning)
// 		[self startMonitor];
// 	else if (monitorIsRunning)
// 		[self stopMonitor];
// }


- (void)mainWindowChangeHandler:(NSNotification*)aNotification
{
//NSLog(@"WINDOW CHANGE: %@", [aNotification object]);
	if ([aNotification.name isEqualToString: NSWindowDidBecomeMainNotification])
	{
		[compilerController setCurrentFilePath: [[aNotification object] representedFilename]];
		
		if ([compilerController isAutoCompilationEnabled] && [compilerController isCurrentFilePathCompilable] && !monitorIsRunning)
			[self startMonitor];
		else if (monitorIsRunning)
			[self stopMonitor];
	}
	else if(monitorIsRunning)
	{
		[self stopMonitor];
	}
}


- (void)refreshTimeoutHandler
{
	refreshTimeoutExpired = YES;
	[self killRefreshTimeout];

	if ([compilerController isAutoCompilationEnabled])
		[self refresh];
}




- (void)refresh
{
	if ([compilerController isCurrentFilePathCompilable])
	{
		// Add an observer to the compiler to catch when the compilation completes.
		[[NSNotificationCenter defaultCenter]
			addObserver: self
			selector: @selector(compileCompleteNotificationHandler:)
			name: @"complete"
			object: nil
		];

		[compilerController compile];
		
		if ([compilerController isAutoCompilationEnabled])
			[self startRefreshTimeout];
	}
}

- (void)killRefreshTimeout
{
	if (refreshTimeout != nil)
	{
		if ([refreshTimeout isValid])
			[refreshTimeout invalidate];

		[refreshTimeout release];
		refreshTimeout = nil;
NSLog(@"Kill refresh timeout.");		
	}
}

- (void)startRefreshTimeout
{
	if (refreshTimeout != nil)
		[self killRefreshTimeout];
	
	refreshTimeoutExpired = NO;
	refreshTimeout = [[NSTimer scheduledTimerWithTimeInterval: 5 target: self selector:@selector(refreshTimeoutHandler) userInfo:nil repeats: NO] retain];		
NSLog(@"Start refresh timeout.");
}

@end

