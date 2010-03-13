//
//  CompilerControllerProtocol.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/12/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol CompilerController
- (IBAction)compile:(id)sender;
- (void)compile;
- (BOOL)isAutoCompilationEnabled;
- (BOOL)isCurrentFilePathCompilable;
- (NSString*)currentFilePath;
- (void)setCurrentFilePath:(NSString*)aString;
@end
