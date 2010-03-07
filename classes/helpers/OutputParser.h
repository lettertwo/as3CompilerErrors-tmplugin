//
//  OutputParser.h
//  CompilerOutputParserTest
//
//  Created by matthew on 3/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface OutputParser : NSObject {
	NSString* buffer;
}

- (void) addToBuffer:(NSString*)aString;
- (void) clearBuffer;
- (void) parse;

@end
