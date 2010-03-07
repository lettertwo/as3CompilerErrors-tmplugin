//
//  CategoryNode.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by matthew on 3/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OutlineViewNode.h";

@interface CategoryNode : OutlineViewNode {
	NSString* nodeValue;
}

- (id)initWithValue:(NSString*)value;

@end
