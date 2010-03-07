//
//  MessageCell.m
//  StandaloneView
//
//  Created by Matthew Tretter on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MessageCell.h";
#import "OutlineViewNode.h";
#import "CompilerMessage.h";

extern NSInteger const PADDING_TOP = 14;
extern NSInteger const GAP = 30;

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
 * Draws the location information (line and column number) in the specified rectangle.
 */
- (void)drawLocationInfoWithFrame:(NSRect)cellFrame inView:(NSView*)controlView
{
	CompilerMessage* message = [[self dataSource] message];
	NSFont* font;
	NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
	[style setAlignment:NSRightTextAlignment];
	
	// Draw the line number.
	NSString* lineNumber = [NSString stringWithFormat:@"%d", [message row]];
	font = [[NSFontManager sharedFontManager] convertFont:[self font] toHaveTrait:NSBoldFontMask];
	NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:
		style, NSParagraphStyleAttributeName,
		font, NSFontAttributeName,
		nil];
	[lineNumber drawInRect:cellFrame withAttributes:attrs]; 
	
	// Draw column info.
 	NSSize lineLabelSize = [lineNumber sizeWithAttributes:attrs];
	NSRect columnFrame = NSMakeRect(cellFrame.origin.x, cellFrame.origin.y + lineLabelSize.height, cellFrame.size.width, cellFrame.size.height);
	NSString* columnNumber = [NSString stringWithFormat:@"col %d", [message column]];
	font = [[NSFontManager sharedFontManager] convertFont:[self font] toHaveTrait:NSBoldFontMask];
	font = [[NSFontManager sharedFontManager] convertFont:font toSize:9];
	attrs = [NSDictionary dictionaryWithObjectsAndKeys:
		style, NSParagraphStyleAttributeName,
		font, NSFontAttributeName,
		[NSColor colorWithDeviceRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1.0], NSForegroundColorAttributeName,
		nil];
	[columnNumber drawInRect:columnFrame withAttributes:attrs];
	
	[style release];
}

/**
 * Gets the data source.
 */
- (OutlineViewNode*)dataSource
{
	return dataSource;
}

/**
 * Draws the contents of the cell.
 */
- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	CompilerMessage* message = [[self dataSource] message];
	NSDictionary* attrs;
	NSFont* font;
	NSRect bounds;

	// Draw the location info.
	NSRect locationFrame = NSMakeRect(cellFrame.origin.x, cellFrame.origin.y + PADDING_TOP, 50, cellFrame.size.height);
	[self drawLocationInfoWithFrame:locationFrame inView:controlView];

	// Draw the description
	bounds = NSMakeRect(locationFrame.origin.x + locationFrame.size.width + GAP, cellFrame.origin.y + PADDING_TOP, cellFrame.size.width - locationFrame.size.width - GAP, cellFrame.size.height);
	NSString* prefix = [NSString stringWithFormat:@"%@:", [message type]];
	NSString* fullDescription = [NSString stringWithFormat:@"%@ %@", prefix, [message descriptionText]];
	NSMutableAttributedString* text = [[NSMutableAttributedString alloc] initWithString:fullDescription];
	font = [[NSFontManager sharedFontManager] convertFont:[self font] toHaveTrait:NSBoldFontMask];
	[text addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, prefix.length)];
	[text drawInRect:bounds];

	// Draw the line of code.
	bounds.origin.y += text.size.height + 10;
	[self drawLineOfCode:[message lineOfCode] withErrorAtColumn:[message column] withFrame:bounds inView:controlView];

	[text release];
}

/**
 * Draws the line of code.
 */
- (void)drawLineOfCode:(NSString*)lineOfCode withErrorAtColumn:(NSInteger)column withFrame:(NSRect)rect inView:(NSView*)controlView
{
// FIXME: This is doing way too much for a redraw. Cache all this stuff or something.
// TODO: Remove beginning whitespace from the line of code.
	// Format the loc.
	NSDictionary* attrs = [NSDictionary dictionaryWithObjectsAndKeys:
// FIXME: Why isn't it listening to this font size?
		[NSFont fontWithName:@"Monaco" size:9], NSFontAttributeName,
		[NSColor colorWithDeviceRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1.0], NSForegroundColorAttributeName,
		nil];
	NSAttributedString* code = [[NSAttributedString alloc] initWithString:lineOfCode attributes:attrs];
	
	NSTextContainer* textContainer = [[NSTextContainer alloc] initWithContainerSize:NSMakeSize(1e7, 1e7)];
	NSTextView* textView = [[NSTextView alloc] init];
	NSLayoutManager* layoutManager = [textView layoutManager];
	[layoutManager addTextContainer:textContainer];
	[textView insertText:code];
	unsigned int length = [code length];
	[textView setSpellingState:NSSpellingStateSpellingFlag range:NSMakeRange(column, 1)];
	NSRange glyphRange = [layoutManager glyphRangeForCharacterRange:NSMakeRange(column, code.length) actualCharacterRange:NULL];

	if (glyphRange.length > 0)
		[layoutManager drawGlyphsForGlyphRange:glyphRange atPoint:rect.origin];
		
	[code release];
	[textContainer release];
	[textView release];
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
