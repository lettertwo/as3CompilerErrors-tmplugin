//
//  MessageNode.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by matthew on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MessageNode.h"


@implementation MessageNode

- (id)initWithMessage:(CompilerMessage*)aMessage
{
	if (self = [super init])
	{
		message = aMessage;
		children = [[NSMutableArray alloc] init];
	}

	return self;
}

- (NSString*)nodeValue
{
	return [message descriptionText];
}

@end
