//
//  OutlineViewNode.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/4/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "OutlineViewNode.h"


@implementation OutlineViewNode

- (id)init
{
	if (self = [super init])
		children = [[NSMutableArray alloc] init];
	return self;
}

- (void)dealloc
{
	[parent release];
	[children release];
	[super dealloc];
}

- (NSInteger)indexOfChild:(OutlineViewNode*)child
{
	return [children indexOfObject:child];
}

- (id)addChild:(id)child
{
	[child setParent:self];
	[children addObject: child];
	return child;
}

- (NSArray*)children
{
	return children;
}

- (id)parent
{
	return parent;
}

- (void)setParent:(id)theParent
{
	[[self parent] release];
	parent = theParent;
}

- (OutlineViewNode*)childAtIndex:(NSInteger)n 
{
    return [children objectAtIndex: n];
}

- (NSInteger)numberOfChildren 
{
	return [children count];
}

@end
