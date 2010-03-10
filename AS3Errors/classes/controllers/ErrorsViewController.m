//
//  ErrorsViewController.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/4/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "ErrorsViewController.h"
#import "MessageCell.h"
#import "CompilerMessage.h"
#import "CategoryNode.h"
#import "MessageNode.h"

@implementation ErrorsViewController

@synthesize dataSource;

- (id)init
{
	if (self = [super init])
	{
		[self setDataSource:[NSMutableDictionary dictionary]];

		//Add an observer to monitor compiler start.
		[[NSNotificationCenter defaultCenter] addObserver: self
			selector: @selector(startNotificationHandler:)
			name: @"start"
			object: nil
		];

		// Add an observer to monitor results from the compiler output parser.
		[[NSNotificationCenter defaultCenter] addObserver:self 
			selector:@selector(errorNotificationHandler:) 
			name:@"resultsAvailable" 
			object: nil
		];
	}

	return self;
}

#pragma mark -
#pragma mark Data Provider Methods

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item 
{
	return item == nil ? [dataSource count] : [item numberOfChildren];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item 
{
	return [item isKindOfClass:[CategoryNode class]] ? YES : NO;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item 
{
	return (item == nil) ? [dataSource objectForKey: [[dataSource allKeys] objectAtIndex: index]] : [item childAtIndex: index];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item 
{
	return (id)[item nodeValue];
}

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
	if ([cell isKindOfClass:[MessageCell class]])
		[cell setDataSource:item];
}

- (CGFloat)outlineView: (NSOutlineView *)outlineView heightOfRowByItem:(id)item
{
	CGFloat height;

	if ([self outlineView:outlineView isItemExpandable:item])
	{
		height = 32;
	}
	else
	{
		// Calculate the height of the item.
height = 63;
	}

	return height;

	/*
        // Get column for Tweet Status
        NSTableColumn *column = [tv tableColumnWithIdentifier:@"text"];
        // Create a copy of the relevant cell - retains text attributes.
        NSCell *cell = [[column dataCellForRow:row] copyWithZone:NULL];
        // Retrieve stringvalue from XML Data
        NSXMLNode *node = [itemNodes objectAtIndex:row];
        [cell setStringValue:[self valueForPath:@"text" ofNode:node]];
// Calculate height using cellSizeForBounds, limiting it to width of column.
        // Add 10 pixels for padding.
        CGFloat height = [cell cellSizeForBounds:
                                NSMakeRect(0.0, 0.0, [column width], 
1000.0)].height+10.0;
// Profile pics are 48x48, so ensure these are fully visible with >=10px padding
        height = MAX(height,58.0);
        // Release the cell copy.
        [cell release];
        return height;
*/
}

#pragma mark -
#pragma mark Notification Handlers

- (void)startNotificationHandler:(NSNotification*)notification
{
	NSEnumerator *enumerator = [dataSource objectEnumerator];
	id value;
	while ((value = [enumerator nextObject])) 
		[value markAsInvalid];

	[view reloadData];
}

- (void)errorNotificationHandler:(NSNotification*)notification
{
	NSArray* results = [[notification userInfo] objectForKey:@"results"];
	CategoryNode* categoryNode = nil;
	MessageNode* messageNode = nil;
	
	for (unsigned int index = 0; index < [results count]; index++)
	{
		id msg = [results objectAtIndex:index];
		NSString* key = [msg file];
		
		// Get the category for this message.
		categoryNode = [dataSource objectForKey: key];
		if (categoryNode == nil)
		{
			categoryNode = [[CategoryNode alloc] initWithValue: key];
			[dataSource setObject: categoryNode forKey: key];
		}

		// Add the message to the category, if it isn't added already.
		messageNode = [categoryNode messageNodeForMessage: msg];
		if (messageNode == nil)
		{
			messageNode = [[MessageNode alloc] initWithMessage: msg andParent: categoryNode];
			[categoryNode addChild: messageNode];
		}
	}

	[view reloadData];
}

@end

