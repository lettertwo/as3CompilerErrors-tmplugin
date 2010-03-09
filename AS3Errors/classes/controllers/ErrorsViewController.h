//
//  ErrorsViewController.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/4/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ErrorsViewController : NSObject 
{
	NSMutableDictionary* dataSource;
	IBOutlet NSOutlineView* view;
}

@property (retain) NSMutableDictionary *dataSource;

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item;

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item;

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item;

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item;

@end


