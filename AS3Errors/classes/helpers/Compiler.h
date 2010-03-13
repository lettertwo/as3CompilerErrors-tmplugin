//
//  Compiler.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/1/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OutputParser.h"


@interface Compiler : NSObject {
	@private OutputParser* parser;
	@private NSTask* task;
}

- (void)compile:(NSString*)aFilePath;
- (void)dealloc;

@end
