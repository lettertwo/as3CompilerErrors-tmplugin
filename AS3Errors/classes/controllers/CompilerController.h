//
//  CompilerController.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/1/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Compiler.h"
#import "AutoCompilationMonitor.h"
#import "CompilerControllerProtocol.h"

@interface CompilerController:NSObject <CompilerController>
{
	@private Compiler* compiler;
	@private AutoCompilationMonitor* autoCompilationMonitor;
	@private BOOL isAutoCompilationEnabled;
	@private NSString* currentFilePath;
}

@property (nonatomic, assign) BOOL isAutoCompilationEnabled;
@property (nonatomic, copy) NSString *currentFilePath;

- (IBAction)compile:(id)sender;
- (IBAction)toggleAutoCompilation:(id)sender;
@end
