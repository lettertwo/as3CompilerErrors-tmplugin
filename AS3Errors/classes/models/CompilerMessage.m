//
//  CompilerMessage.m
//  CompilerOutputParserTest
//
//  Created by matthew on 3/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CompilerMessage.h"


@implementation CompilerMessage

@synthesize file;
@synthesize row;
@synthesize column;
@synthesize type;
@synthesize descriptionText;
@synthesize lineOfCode;

- (id) initWithFile: (NSString*)aFile row:(NSInteger)aRow column:(NSInteger)aColumn type:(NSString*)aType descriptionText:(NSString*)aDescription lineOfCode:(NSString*)aLineOfCode
{
	if (self = [super init])
	{
		[self setFile:aFile];
		[self setRow:aRow];
		[self setColumn:aColumn];
		[self setType:aType];
		[self setDescriptionText:aDescription];
		[self setLineOfCode:aLineOfCode];
	}
	return self;
}

- (void) dealloc
{
	[file release];
	[type release];
	[descriptionText release];
	[lineOfCode release];
	[super dealloc];
}

-(id) copyWithZone:(NSZone*)zone 
{
	return [[CompilerMessage alloc] initWithFile: file row: row column: column type: type descriptionText: descriptionText lineOfCode: lineOfCode];
}


- (NSString*)messageId
{
	return [CompilerMessage generateMessageId: self];
}

// Static util for generating an id for a compiler message.
+ (NSString*)generateMessageId:(CompilerMessage*)aMessage
{
	return [NSString stringWithFormat: @"%@%d%d%@%@%@", [aMessage file], [aMessage row], [aMessage column], [aMessage type], [aMessage descriptionText], [aMessage lineOfCode]];
}

@end
