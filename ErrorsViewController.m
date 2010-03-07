//
//  ErrorsViewController.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/4/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "ErrorsViewController.h"
#import "OutlineViewNode.h"
#import "CompilerMessage.h"

@implementation ErrorsViewController

- (id)init
{
	if (self = [super init])
	{
		// Add an observer to monitor results from the compiler output parser.
		[[NSNotificationCenter defaultCenter] addObserver:self 
			selector:@selector(errorNotificationHandler:) 
			name:@"resultsAvailable" 
			object: nil
		];
	}

	return self;
}

//
// notification handlers
//

- (void)errorNotificationHandler:(NSNotification*)notification
{
	NSMutableArray* results = [[notification userInfo] objectForKey:@"results"];
	for (unsigned int index = 0; index < [results count]; index++)
	{
		id msg = [results objectAtIndex:index];

		id categoryNode = [self getNodeForMessage: msg asCategory: YES];

		[(OutlineViewNode*)categoryNode addChild: [self getNodeForMessage: msg asCategory: NO]];
		
		[[self dataSource] addObject: categoryNode];
		NSLog(@"ERROR:%@ ", msg);
	}

	
	[view reloadData];
}

- (id)getNodeForMessage:(id)aMsg asCategory:(BOOL)asCategory
{
	OutlineViewNode* node = [[OutlineViewNode alloc] initWithValue: asCategory ? [(CompilerMessage*)aMsg file] : [(CompilerMessage*)aMsg message]];
	return node;

		// 
		// NSLog(@"Message #%d:", index);
		// NSLog(@"\tfile:\t%@", [msg file]);
		// NSLog(@"\trow:\t%d", [msg row]);
		// NSLog(@"\tcolumn:\t%d", [msg column]);
		// NSLog(@"\ttype:\t%@", [msg type]);
		// NSLog(@"\tmessage:\t%@", [msg message]);
		// NSLog(@"\tline:\t%@", [msg line]);
		// NSLog(@"\n");
}

@end
