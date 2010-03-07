//
//  WarningsViewController.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/4/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "WarningsViewController.h"


@implementation WarningsViewController

- (id)init
{
	if (self = [super init])
	{
		// Add an observer to monitor compiler warnings.
		[[NSNotificationCenter defaultCenter] addObserver: self 
			selector: @selector(warningNotificationHandler:)
			name: @"warning"
			object: nil
		];
	}

	return self;
}


//
// notification handlers
//

- (void)warningNotificationHandler:(NSNotification*)notification
{
	[view reloadData];
}

@end
