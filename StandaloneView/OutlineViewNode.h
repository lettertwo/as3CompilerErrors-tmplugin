//
//  OutlineViewNode.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/4/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface OutlineViewNode : NSObject {
	NSString *nodeValue;
	NSMutableArray *children;
	id parent;
}
- (id)addChild:(id)object;
- (id)initWithValue:(NSString*)value;
- (NSInteger)numberOfChildren;
- (OutlineViewNode*)childAtIndex:(NSInteger)n;
- (NSString*)nodeValue;
- (id)parent;
- (NSInteger)indexOfChild:(OutlineViewNode*)child;

// Shouldn't be exposed.
- (void)setParent:(id)parent;

@end
