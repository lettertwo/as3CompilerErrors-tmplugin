//
//  OutlineViewNode.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/4/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "OutlineViewNode.h"


@implementation OutlineViewNode

- (id)initWithValue:(NSString *)value
{
	if (self = [super init])
	{
		nodeValue = [value copy];
		children = [[NSMutableArray alloc] init];
	}

	return self;
}

- (void)dealloc
{
	[children release];
	[nodeValue release];
	[super dealloc];
}

- (id)addChild:(id)child
{
	[children addObject: child];
	return child;
}

- (NSArray*)children
{
	return children;
}

- (NSString*)nodeValue
{
	return nodeValue;
}

- (OutlineViewNode *)childAtIndex:(NSInteger)n 
{
	NSLog(@"getting child at index %d from a total number of %d.", n, [children count]);
    return [children objectAtIndex: n];
}

- (NSInteger)numberOfChildren 
{
	return [children count];
}

@end
