//
//  Main.m
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/1/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import "Main.h"


@implementation Main
- (id)initWithPlugInController:(id <TMPlugInController>)aController
{
	NSApp = [NSApplication sharedApplication];
	if (self = [super init])
		[self installMenuItem];
	return self;
}

- (void)dealloc
{
	[self uninstallMenuItem];
	[self disposePalette];
	[super dealloc];
}

- (void)installMenuItem
{
	if (windowMenu = [[[[NSApp mainMenu] itemWithTitle:@"Window"] submenu] retain])
	{
		NSArray *items = [windowMenu itemArray];
		unsigned index = 0;

		// Locate the correct location on the Window submenu to place the new menu item.
		for (int separators = 0; index != [items count] && separators != 2; index++)
			separators += [[items objectAtIndex:index] isSeparatorItem] ? 1 : 0;
		
		menuItem = [[NSMenuItem alloc] initWithTitle:@"AS3 Compiler Errors" action:@selector(showPalette:) keyEquivalent:@""];
		[menuItem setTarget:self];
	 	[windowMenu insertItem:menuItem atIndex:index ? index-1 : 0];
	}
}

- (void)uninstallMenuItem
{
	[windowMenu removeItem:menuItem];

	[menuItem release];
	menuItem = nil;

	[windowMenu release];
	windowMenu = nil;
}

- (void)showPalette:(id)sender
{
	if(!mainWindowController)
	{
		NSWindowController* obj = [NSWindowController alloc]; // this is a little hacky, since initXYZ could change the obj, but the path variant of initWithNib needs an owner
		NSString* nibPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"CompilerErrors" ofType:@"nib"];
		mainWindowController = [obj initWithWindowNibPath:nibPath owner:obj];
	}
	[mainWindowController showWindow:self];
}

- (void)disposePalette
{
	[mainWindowController close];
	[mainWindowController release];
	mainWindowController = nil;
}

@end
