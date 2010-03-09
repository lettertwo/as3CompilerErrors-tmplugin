//
//  ErrorsViewController.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/4/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "ErrorsViewController.h"
#import "OutlineViewNode.h"
#import "MessageCell.h"
#import "MessageNode.h"
#import "CategoryNode.h"
#import "CompilerMessage.h"

@implementation ErrorsViewController



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
	if (item == nil)
	{
		return [dataSource objectForKey: [[dataSource allKeys] objectAtIndex: index]];
	}
	else
	{
		return [item childAtIndex: index];
	}
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item 
{
	return (id)[item nodeValue];
}


//
// notification handlers
//

- (void)startNotificationHandler:(NSNotification*)notification
{
	[dataSource removeAllObjects];
	[view reloadData];
}

- (void)errorNotificationHandler:(NSNotification*)notification
{
	NSMutableArray* results = [[notification userInfo] objectForKey:@"results"];
	CategoryNode* categoryNode = nil;
	
	for (unsigned int index = 0; index < [results count]; index++)
	{
		id msg = [results objectAtIndex:index];
		NSString* key = [msg file];
		
		categoryNode = [[self dataSource] objectForKey: key];
		
		if (categoryNode == nil)
		{
			categoryNode = [[CategoryNode alloc] initWithValue: key];
			[[self dataSource] setObject: categoryNode forKey: key];
		}
		[categoryNode addChild: [[MessageNode alloc] initWithMessage: msg]];
	}
	
	
// 	OutlineViewNode* categoryNode = nil;
// 
// 	for (unsigned int index = 0; index < [results count]; index++)
// 	{
// 		id msg = [results objectAtIndex:index];
// // TODO: If caegory exists, add to it. Else, create.
// 		if (categoryNode == nil)
// 		{
// 			categoryNode = [[CategoryNode alloc] initWithValue: [msg file]];
// 			[[self dataSource] addObject: categoryNode];
// 		}
// 		[categoryNode addChild: [[MessageNode alloc] initWithMessage: msg]];
// 	}

	[view reloadData];
}


/**
 *
 */
- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
	if ([cell isKindOfClass:[MessageCell class]])
		[cell setDataSource:item];
}



/**
 *
 */
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


// - (void)addTestData
// {
// 	NSMutableArray* messages = [NSMutableArray array];
// 	for (unsigned int i = 0; i < 3; i++)
// 	{
// 		CompilerMessage* msg = [[CompilerMessage alloc]
// 			initWithFile:[NSString stringWithFormat:@"/Users/matthew/Desktop/My Class - %d", i]
// 			row:105
// 			column:6
// 			type:@"Error"
// 			descriptionText:@"There is an error in your code."
// 			lineOfCode:@"      i = 6;"];
// 		[messages addObject:msg];
// 	}
// 	
// 	[[NSNotificationCenter defaultCenter] postNotificationName:@"resultsAvailable" object:nil userInfo:[NSDictionary dictionaryWithObject:messages forKey:@"results"]];
// }

@end

