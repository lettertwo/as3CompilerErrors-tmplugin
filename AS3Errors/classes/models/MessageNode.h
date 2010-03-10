//
//  MessageNode.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by matthew on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OutlineViewNode.h"
#import "CompilerMessage.h"

@interface MessageNode : OutlineViewNode 
{
	@private CompilerMessage* message;
	@private id parent;
}
- (id)initWithMessage:(CompilerMessage*)aMessage andParent:(id)aParent;
- (CompilerMessage*)message;
- (id)parent;
- (NSString*)messageId;
@end
