//
//  CompilerController.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/1/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Compiler.h"


@interface CompilerController : NSObject {
	Compiler* compiler;
}

@property (nonatomic, retain) Compiler* compiler;

- (IBAction)compile:(id)sender;
- (void)dealloc;
@end
