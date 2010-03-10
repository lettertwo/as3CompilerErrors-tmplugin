//
//  MessageNode.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by matthew on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MessageNode.h"


@implementation MessageNode

- (id)initWithMessage:(CompilerMessage*)aMessage andParent:(id)aParent
{
	if (self = [super initWithValue: [aMessage descriptionText]])
	{
		message = aMessage;
		parent = aParent;
	}

	return self;
}

- (CompilerMessage*)message
{
	return message;
}

- (id)parent
{
	return parent;
}

- (NSString*)messageId
{
	return [message messageId];
}

@end
