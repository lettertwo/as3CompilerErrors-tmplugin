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
	return [self initWithValue:nil];
}

- (id)initWithValue:(NSString*)value
{
	if (self = [super init])
		nodeValue = [value copy];

	return self;
}

- (void)dealloc
{
	[nodeValue release];
	[super dealloc];
}	

- (NSInteger)numberOfChildren
{
	return [children count];
}

- (NSInteger)indexOfChild:(id)aChild
{
	return [children indexOfObject: aChild];
}

- (void)addChild:(id)aChild
{
	if (children == nil)
		children = [[NSMutableArray alloc] init];

	[children addObject: aChild];
}

- (id)childAtIndex:(NSInteger)n
{
	return [children objectAtIndex: n];
}

- (NSString*)nodeValue
{
	return nodeValue;
}

- (void)markAsInvalid
{
	isValid = NO;
}

@end
