//
//  MessagesTableColumn.m
//  StandaloneView
//
//  Created by Matthew Tretter on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MessagesTableColumn.h"
#import "MessageCell.h";
#import "CategoryCell.h";

@interface MessagesTableColumn (Private)
	- (void)setup;
@end

@implementation MessagesTableColumn

- (id) init
{
	if (self = [super init])
	{
		[self setup];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
	if (self = [super initWithCoder:decoder])
	{
		[self setup];
	}
	return self;
}

- (id) dataCellForRow:(int)row;
{
	NSOutlineView *outlineView = (NSOutlineView *)[self tableView];
	int level = [outlineView levelForRow:row];

	return ( level == 0 ) ? (id)categoryCell : (id)messageCell;
}

#pragma mark -
#pragma mark Private methods

/**
 *
 */
- (void) setup
{
	categoryCell = [[CategoryCell alloc] init];
	messageCell = [[MessageCell alloc] init];
}

@end
