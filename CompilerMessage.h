//
//  CompilerMessage.h
//  CompilerOutputParserTest
//
//  Created by matthew on 3/4/10.
//  copy, nonatomicright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CompilerMessage : NSObject {
	NSString* file;
	NSInteger row;
	NSInteger column;
	NSString* type;
	NSString* message;
	NSString* line;
}

@property (copy, nonatomic) NSString* file;
@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger column;
@property (copy, nonatomic) NSString* type;
@property (copy, nonatomic) NSString* message;
@property (copy, nonatomic) NSString* line;

- (id) initWithFile: (NSString*)aFile row:(NSInteger)aRow column:(NSInteger)aColumn type:(NSString*)aType message:(NSString*)aMessage line:(NSString*)aLine;

@end
