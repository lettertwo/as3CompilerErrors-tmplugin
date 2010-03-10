//
//  OutlineViewNode.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/4/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OutlineViewNode : NSObject
{
	NSMutableArray* children;
	NSString* nodeValue;
	BOOL isValid;
}
- (id)initWithValue:(NSString*)value;

- (NSString*)nodeValue;
- (NSInteger)numberOfChildren;
- (NSInteger)indexOfChild:(id)aChild;
- (void)addChild:(id)aChild;
- (id)childAtIndex:(NSInteger)n;
- (void)markAsInvalid;

@end
