//
//  CategoryCell.m
//  StandaloneView
//
//  Created by Matthew Tretter on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CategoryCell.h"

extern NSInteger const LABEL_OFFSET = 32;

@implementation CategoryCell

@synthesize textAttributes;

/**
 * Initializes the object.
 */
- (id)initTextCell:(NSString *)aString
{
	if (self = [super initTextCell:aString])
	{
		[self initStyle];
	}
	return self;
}

/**
 * Config the style of the cell.
 */
- (void)initStyle
{
	// Create the textAttributes dictionary (which will be used by the draw function).
	// TODO: Only create this once (not once per instance)
	NSShadow* textShadow = [[NSShadow alloc] init];
	[textShadow setShadowColor: [NSColor colorWithCalibratedRed: 1.0 green: 1.0 blue: 1.0 alpha: 1.0]];
	[textShadow setShadowOffset: NSMakeSize(0.0, -1.0)];
	NSFont* font = [[NSFontManager sharedFontManager] convertFont:[self font] toHaveTrait:NSBoldFontMask];
	[self setTextAttributes:
		[NSDictionary dictionaryWithObjectsAndKeys:
			textShadow, NSShadowAttributeName,
			font, NSFontAttributeName,
			nil]];

	[self setTextColor:[NSColor colorWithDeviceRed:61/255.0 green: 61/255.0 blue:61/255.0 alpha:1.0]];
	[self setFont:[NSFont labelFontOfSize:13.0]];
	[self setWraps:NO];
	[self setLineBreakMode:NSLineBreakByTruncatingHead];
}

/**
 * Called by drawInteriorWithFrame:inView: to determine the area the title should be drawn into.
 */
- (NSRect)titleRectForBounds:(NSRect)theRect {
    NSRect titleFrame = [super titleRectForBounds:theRect];
    NSSize titleSize = [[self attributedStringValue] size];
    titleFrame.origin.y = theRect.origin.y + (theRect.size.height - titleSize.height) / 2.0;
	titleFrame.origin.x += LABEL_OFFSET;
	titleFrame.size.width -= LABEL_OFFSET;
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
 * Draw the cell.
 */
- (void) drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	// Draw the gradient background.
	NSGradient* aGradient = [[[NSGradient alloc]
		initWithColorsAndLocations:
			[NSColor colorWithDeviceRed:219/255.0 green: 219/255.0 blue:219/255.0 alpha:1.0], (CGFloat)0.0,
			[NSColor colorWithDeviceRed:202/255.0 green: 202/255.0 blue:202/255.0 alpha:1.0], (CGFloat)1.0,
			nil] autorelease];
	[aGradient drawInRect:cellFrame angle:90.0];
	
	// Draw the bottom border.
	[[NSColor colorWithDeviceRed:162/255.0 green:162/255.0 blue:162/255.0 alpha:1.0] set];
	NSRectFill(NSMakeRect(cellFrame.origin.x, cellFrame.origin.y + cellFrame.size.height - 1, cellFrame.size.width, 1));
	
	// Draw the top border.
	[[NSColor colorWithDeviceRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1.0] set];
	NSRectFill(NSMakeRect(cellFrame.origin.x, cellFrame.origin.y, cellFrame.size.width, 1));

	// Draw the text.
	NSMutableAttributedString* newString = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedStringValue]];
	[newString addAttributes:[self textAttributes] range:NSMakeRange(0, newString.length)];
	[self setAttributedStringValue: newString];
	[newString release];

	// FIXME: Does this draws stuff we don't need?
	[super drawWithFrame:cellFrame inView:controlView];
}

@end
