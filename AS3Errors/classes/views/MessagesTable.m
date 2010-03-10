//
//  MessagesTable.m
//  StandaloneView
//
//  Created by matthew on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MessagesTable.h"


@implementation MessagesTable

- (void)awakeFromNib
{
	[self expandItem:nil expandChildren:YES];
}

- (id)initWithCoder:(NSCoder *)decoder
{
	if (self = [super initWithCoder:decoder])
	{
		[self setIntercellSpacing:NSMakeSize(0.0, 0.0)];
	}
	return self;
}

/**
 * Overridden to indent the disclosure triangle a little more.
 */
- (NSRect)frameOfOutlineCellAtRow:(NSInteger)row
{
	NSRect rect = [super frameOfOutlineCellAtRow:row];
	rect.origin.x += 11;
	return rect;
}

/**
 * Overridden because we don't need highlighting.
 */
- (void)highlightSelectionInClipRect:(NSRect)clipRect
{
}


/**
 * Overridden to facilitate an 'expansion' memory.
 */
- (void)expandItem:(id)item
{
	
	NSLog(@"EXPANDING %@", item);
	
	[super expandItem: item];
}

@end
