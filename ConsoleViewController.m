//
//  ConsoleViewController.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/3/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "ConsoleViewController.h"

@implementation ConsoleViewController

- (id)init
{
	if (self = [super init])
	{
		// Add an observer to monitor compiler start.
		[[NSNotificationCenter defaultCenter] addObserver: self
			selector: @selector(startNotificationHandler:)
			name: @"start"
			object: nil
		];
		
		// Add an observer to monitor compiler output.
		[[NSNotificationCenter defaultCenter] addObserver: self 
			selector: @selector(outputNotificationHandler:)
			name: @"output"
			object: nil
		];
	}
	return self;
}

- (void)clear
{
	NSTextStorage* textStorage = [view textStorage];
	[textStorage beginEditing];
	[textStorage deleteCharactersInRange:NSMakeRange(0, [textStorage length])];
	[textStorage endEditing];
}

- (void)outputNotificationHandler:(NSNotification*)notification
{
	[self print:[notification object]];
}

- (void)print:(NSString*)string
{
	NSTextStorage* textStorage = [view textStorage];
	[textStorage beginEditing];
	[textStorage replaceCharactersInRange:NSMakeRange([textStorage length], 0) withString:string];
	[textStorage endEditing];
}

- (void)startNotificationHandler:(NSNotification*)notification
{
	[self clear];
}

@end
