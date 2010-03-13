//
//  OakTextViewProxy.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/11/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "OakTextViewProxy.h"

// TODO: Figure out a way to identify the OakTextView without this hackery.
// Begin OakTextView Class hack.
#pragma mark -

@interface OakTextView:NSObject {}
@end

@interface OakTextView (Internal)
@end
// @interface OakTextView : NSObject {}
// @end
// 
// @interface OakTextView (ShutUpWarnings)
// + (id)defaultEnvironmentVariables;
// - (id)environmentVariables;
// - (void)setNeedsDisplay:(BOOL)yn;
// - (id)stringValue;
// - (void)goToLineNumber:(id)fp8;
// - (void)goToColumnNumber:(id)fp8;
// - (void)selectToLine:(id)fp8 andColumn:(id)fp12;
// - (void)centerSelectionInVisibleArea:(id)fp8;
// - (void)scrollViewByX:(CGFloat)fp8 byY:(long)fp12;
// 
// - (void)centerCaretInDisplay:(id)fp8;
// - (void)setSelectionNeedsDisplay:(BOOL)fp8;
// - (id)wordAtCaret;
// - (id)xmlRepresentationForSelection:(BOOL)fp8;
// - (id)xmlRepresentation;
// - (id)xmlRepresentationForSelection;
// - (NSInteger)currentIndentForContent:(id)fp8 atLine:(unsigned long)fp12;
// - (NSInteger)indentForCurrentLine;
// - (unsigned long)currentIndent;
// - (unsigned long)indentLine:(unsigned long)fp8;
// 
// 
// - (id)attributedSubstringFromRange:(struct _NSRange)fp8;
// - (void)setMarkedText:(id)fp8 selectedRange:(struct _NSRange)fp12;
// - (BOOL)hasMarkedText;
// - (struct _NSRange)markedRange;
// - (struct _NSRange)selectedRange;
// - (id)validAttributesForMarkedText;
// @end

@implementation OakTextView
@end

// End hack.
#pragma mark -


@interface OakTextViewProxy (Private)
+ (NSScrollView*)findNestedTextViewInView:(NSView*)aView;
@end

#pragma mark -

@implementation OakTextViewProxy

#pragma mark -
#pragma mark Initialization Methods

- (id)initWithOakTextView:(id)anOakTextView
{
	if (self = [super init])
		oakTextView = anOakTextView;
	
	return self;
}

- (void)dealloc
{
	[oakTextView release];
	[super dealloc];
}

#pragma mark -
#pragma mark Public Static Methods

+ (OakTextViewProxy*)proxyForCurrentOakTextView
{
	return [[OakTextViewProxy alloc] initWithOakTextView: [OakTextViewProxy findNestedTextViewInView: [[NSApp mainWindow] contentView]]];
}

@end


#pragma mark -
#pragma mark Private Static Methods

@implementation OakTextViewProxy (Private)

+ (NSScrollView*)findNestedTextViewInView:(NSView*)aView
{
	NSEnumerator* enumerator = [[aView subviews] objectEnumerator];
	id view;
	while (view = [enumerator nextObject])
	{
		if ([view isKindOfClass: [OakTextView class]])
			return view;
		else
			view = [OakTextViewProxy findNestedTextViewInView: view];
		
		if ([view isKindOfClass: [OakTextView class]])
			return view;
	}

	return nil;
}

@end
