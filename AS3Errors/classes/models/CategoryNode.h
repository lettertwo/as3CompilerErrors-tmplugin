//
//  CategoryNode.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by matthew on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>;
#import "OutlineViewNode.h"
#import "MessageNode.h"
#import "CompilerMessage.h"

@interface CategoryNode : OutlineViewNode
{
	@private NSMutableDictionary* messageNodes;
	@private BOOL isSorted;
}

- (MessageNode*)messageNodeForMessage:(CompilerMessage*)aMessage;

@end
