//
//  AutoCompilationMonitor.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/12/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CompilerControllerProtocol.h"

@interface AutoCompilationMonitor:NSObject
{
	@private BOOL monitorIsRunning;
	@private id <CompilerController> compilerController;
	
	@private BOOL refreshTimeoutExpired;
	@private NSTimer* refreshTimeout;

}

- (id)initWithCompilerController:(id <CompilerController>)aController;
- (void)startMonitor;
- (void)stopMonitor;

@end
