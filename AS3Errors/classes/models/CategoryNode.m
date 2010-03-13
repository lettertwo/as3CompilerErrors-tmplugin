//
//  CategoryNode.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by matthew on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CategoryNode.h"
#import "MessageNode.h"
#import "CompilerMessage.h"

@implementation MessageNode (comparison)
- (NSComparisonResult)compare:(MessageNode*)other
{
	// This message node row and column.
	NSInteger rowNum = [[self message] row];
	NSInteger colNum = [[self message] column];

	// Other message node row and column.
	NSInteger otherRowNum = [[other message] row];
	NSInteger otherColNum = [[other message] column];

	if (rowNum > otherRowNum)
	{
		return NSOrderedDescending;
	}
	else if (rowNum < otherRowNum)
	{
		return NSOrderedAscending;
	}
	else if (colNum > otherColNum)
	{
		return NSOrderedDescending;
	}
	else if (colNum < otherColNum)
	{
		return NSOrderedAscending;
	}
	else
	{
		return NSOrderedSame;
//		[NSException raise:@"Duplicate message location" format:@"%@ and %@ have the same location (row: %d, col: %d)", other, self, rowNum, colNum];
	}
}
@end

#pragma mark -

@interface CategoryNode (Private)
- (void)sortMessageNodes;
@end

#pragma mark -

@implementation CategoryNode
// TODO: implement some kind of 'invalid' or 'stale' behavior to accommodate removing only old errors and keeping recurring ones.

- (id)initWithValue:(NSString*)aString
{
	if (self = [super initWithValue: aString])
	{
		messageNodes = [[NSMutableDictionary alloc] init];
		isSorted = NO;
	}

	return self;
}

- (void)dealloc
{
 	[messageNodes release];
	[super dealloc];
}

#pragma mark -
#pragma mark Public Methods

- (NSInteger)numberOfChildren
{
	if (isSorted == NO)
		[self sortMessageNodes];
	
	return [super numberOfChildren];
}

- (NSInteger)indexOfChild:(id)aChild
{
	if (isSorted == NO)
		[self sortMessageNodes];
	
	return [super indexOfChild: aChild];
}

- (id)childAtIndex:(NSInteger)n
{
	if (isSorted == NO)
		[self sortMessageNodes];
	
	return [super childAtIndex: n];
}

- (void)addChild:(id)aChild
{
	if ([aChild isKindOfClass: [MessageNode class]] == NO)
		[NSException raise:@"Invalid Child" format:@"A CategoryNode only accepts MessageNodes as children."];

	if ([messageNodes objectForKey: [aChild messageId]] == nil)
	{
		[messageNodes setObject: aChild forKey: [aChild messageId]];
		isSorted = NO;
	}
}

- (MessageNode*)messageNodeForMessage:(CompilerMessage*)aMessage
{
	return [messageNodes objectForKey: [aMessage messageId]];
}

#pragma mark -
#pragma mark Private methods

- (void)sortMessageNodes
{
	if (isSorted == NO)
	{
		NSArray* sortedKeys = [messageNodes keysSortedByValueUsingSelector: @selector(compare:)];

		if (children != nil)
			[children release];

		children = [[NSMutableArray alloc] initWithArray: [messageNodes objectsForKeys: sortedKeys notFoundMarker: nil]];

		isSorted = YES;
	}
}

@end