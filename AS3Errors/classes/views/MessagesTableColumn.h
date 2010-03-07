//
//  MessagesTableColumn.h
//  StandaloneView
//
//  Created by Matthew Tretter on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MessagesTableColumn : NSTableColumn {
	NSCell* categoryCell;
	NSCell* messageCell;
}

@end
