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
@synthesize message;
@synthesize line;

- (id) initWithFile: (NSString*)aFile row:(NSInteger)aRow column:(NSInteger)aColumn type:(NSString*)aType message:(NSString*)aMessage line:(NSString*)aLine
{
	if (self = [super init])
	{
		[self setFile:aFile];
		[self setRow:aRow];
		[self setColumn:aColumn];
		[self setType:aType];
		[self setMessage:aMessage];
		[self setLine:aLine];
	}
	return self;
}

- (void) dealloc
{
	[file release];
	[type release];
	[message release];
	[line release];
	[super dealloc];
}

@end
