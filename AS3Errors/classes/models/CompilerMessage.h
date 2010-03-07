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
	NSString* descriptionText;
	NSString* lineOfCode;
}

@property (copy, nonatomic) NSString* file;
@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger column;
@property (copy, nonatomic) NSString* type;
@property (copy, nonatomic) NSString* descriptionText;
@property (copy, nonatomic) NSString* lineOfCode;

- (id) initWithFile: (NSString*)aFile row:(NSInteger)aRow column:(NSInteger)aColumn type:(NSString*)aType descriptionText:(NSString*)aDescription lineOfCode:(NSString*)aLineOfCode;

@end
