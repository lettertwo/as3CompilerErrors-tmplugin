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
	NSString* compilerPath;
	@private OutputParser* parser;
}

@property (nonatomic, copy) NSString* compilerPath;

- (id)init;
- (id)initWithCompilerPath:(NSString*)path;
- (void)compile;
- (void)dealloc;

@end
