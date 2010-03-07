//
//  Main.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/1/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol TMPlugInController <NSObject>
- (float)version;
@end

@interface Main : NSObject {
	NSWindowController* mainWindowController;
	NSMenu* windowMenu;
	NSMenuItem* menuItem;
}
- (id)initWithPlugInController:(id <TMPlugInController>)aController;
- (void)dealloc;

- (void)installMenuItem;
- (void)uninstallMenuItem;

- (void)showPalette:(id)sender;
- (void)disposePalette;

@end
