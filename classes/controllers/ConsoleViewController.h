//
//  ConsoleViewController.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/3/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ConsoleViewController : NSObject
{
	IBOutlet NSTextView* view;
}

- (void)clear;
- (void)print:(NSString*)string;

@end
