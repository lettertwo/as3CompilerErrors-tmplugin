//
//  MessageCell.h
//  StandaloneView
//
//  Created by Matthew Tretter on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OutlineViewNode.h";

@interface MessageCell : NSTextFieldCell {
	NSColor* backgroundColor;
	id dataSource;
}

- (OutlineViewNode*)dataSource;
- (void)setDataSource:(OutlineViewNode*)dataSource;

@end
