//
//  CategoryNode.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by matthew on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CategoryNode.h"


@implementation CategoryNode

- (id)initWithValue:(NSString*)value
{
	if (self = [super init])
		nodeValue = value;
	return self;
}

- (NSString*)nodeValue
{
	return nodeValue;
}

@end
