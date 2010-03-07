//
//  MessageCell.m
//  StandaloneView
//
//  Created by Matthew Tretter on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MessageCell.h";
#import "OutlineViewNode.h";

extern NSInteger const PADDING_TOP = 14;
extern NSInteger const DESCRIPTION_X = 80;

@implementation MessageCell

/**
 * Draw the cell.
 */
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView*)controlView
{
	// Draw the background.
	[backgroundColor set];
	NSRectFill(NSMakeRect(cellFrame.origin.x, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height));

	// Draw the bottom border.
	[[NSColor colorWithDeviceRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0] set];
	NSRectFill(NSMakeRect(cellFrame.origin.x, cellFrame.origin.y + cellFrame.size.height - 1, cellFrame.size.width, 1));

	[super drawWithFrame:cellFrame inView:controlView];
}

/**
 * Gets the data source.
 */
- (OutlineViewNode*)dataSource
{
	return dataSource;
}

/**
 * Called by drawInteriorWithFrame:inView: to determine the area the title should be drawn into.
 */
- (NSRect)titleRectForBounds:(NSRect)theRect {
    NSRect titleFrame = [super titleRectForBounds:theRect];
    NSSize titleSize = [[self attributedStringValue] size];
    titleFrame.origin.y += PADDING_TOP;
	titleFrame.origin.x += DESCRIPTION_X;
	titleFrame.size.width -= DESCRIPTION_X;
    return titleFrame;
}

/**
 * Overriden to correctly position title.
 */
- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    NSRect titleRect = [self titleRectForBounds:cellFrame];
    [[self attributedStringValue] drawInRect:titleRect];
}

/**
 *
 */
- (void)setDataSource:(OutlineViewNode*)theDataSource
{
	dataSource = theDataSource;
	NSInteger index =  [[theDataSource parent] indexOfChild:theDataSource];
	backgroundColor = index % 2 == 0 ? [NSColor colorWithDeviceRed:1.0 green:1.0 blue:1.0 alpha:1.0] : [NSColor colorWithDeviceRed:240/255.0 green:246/255.0 blue:245/255.0 alpha:1.0];
}

@end
