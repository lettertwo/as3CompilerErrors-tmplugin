//
//  OutlineViewController.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/4/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "OutlineViewController.h"
#import "OutlineViewNode.h"

@implementation OutlineViewController

@synthesize dataSource;

- (id)init
{
	if (self = [super init])
	{
		[self setDataSource:[NSMutableArray array]];

		// Add an observer to monitor compiler start.
		[[NSNotificationCenter defaultCenter] addObserver: self
			selector: @selector(startNotificationHandler:)
			name: @"start"
			object: nil
		];
	}

	return self;
}


//
// data provider methods
//
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item 
{
	return item == nil ? [dataSource count] : [item numberOfChildren];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item 
{
	return [item numberOfChildren] > 0;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item 
{
	return item == nil ? [dataSource objectAtIndex: index] : [item childAtIndex: index];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item 
{
	return [item nodeValue];
}


//
// notification handlers
//

- (void)startNotificationHandler:(NSNotification*)notification
{
	[dataSource removeAllObjects];
	[view reloadData];
}

@end
