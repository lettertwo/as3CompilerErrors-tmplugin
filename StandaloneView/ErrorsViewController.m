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

@implementation ErrorsViewController

- (id)init
{
	if (self = [super init])
	{
		// Add an observer to monitor compiler errors.
		[[NSNotificationCenter defaultCenter] addObserver: self 
			selector: @selector(errorNotificationHandler:)
			name: @"error"
			object: nil
		];
	}
	[self errorNotificationHandler:nil];
	return self;
}

//
// notification handlers
//

- (void)errorNotificationHandler:(NSNotification*)notification
{
	for(size_t i = 0; i < 3; ++i)
	{
		// Parent
		OutlineViewNode* node = [[OutlineViewNode alloc] initWithValue:[NSString stringWithFormat:@"/Users/ede/Desktop/junk/Junk%d.as", i]];
		
		// Add children.
		[node addChild: [[OutlineViewNode alloc] initWithValue: @"Syntax error: expecting rightbrace before semicolon."]];
		[node addChild: [[OutlineViewNode alloc] initWithValue: @"Syntax error: expected a definition keyword (such as function) after attribute i, not hate."]];
		[node addChild: [[OutlineViewNode alloc] initWithValue: @"Syntax error: expected a definition keyword (such as function) after attribute i, not hate."]];
		[[self dataSource] addObject: node];
	}
	
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


@end

