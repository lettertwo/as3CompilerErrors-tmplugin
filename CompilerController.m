//
//  CompilerController.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/1/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "CompilerController.h"

@implementation CompilerController

@synthesize compiler;

- (IBAction)compile:(id)sender
{
	// Create a new compiler.
	self.compiler = [[Compiler alloc] init];
	
	// Add an observer to the compiler to catch when the compilation completes.
	[[NSNotificationCenter defaultCenter]
		addObserver: self
		selector: @selector(compileCompleteNotificationHandler:)
		name: @"complete"
		object: nil
	];
	
	// Start the compilation.
	[self.compiler compile];
}

- (void)compileCompleteNotificationHandler:(NSNotification*)notification
{	
	[[NSNotificationCenter defaultCenter] removeObserver:self name: @"complete" object: nil];
	self.compiler = nil;
}

- (void)dealloc
{
	[super dealloc];
}

@end
