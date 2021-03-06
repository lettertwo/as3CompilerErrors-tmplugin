//
//  OutputParser.m
//  CompilerOutputParserTest
//
//  Created by matthew on 3/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OutputParser.h";
#import "CompilerMessage.h";
#import "RegexKitLite.h";

static NSString* const MESSAGE_REGEX = @"(?m)^(/[^(]+)\\(([0-9]+)\\): col: ([0-9]+) ([^:]+): (.*)\\n\\n(.*)\\n"; //  new

@implementation OutputParser

- (id) init
{
	if (self = [super init])
	{
		buffer = @"";
	}
	return self;
}

- (void) addToBuffer:(NSString*)aString
{
	buffer = [NSMutableString stringWithFormat:@"%@%@", buffer, aString];
	[buffer replaceOccurrencesOfRegex:@"[\\r\\f]+" withString:@""];
}

- (void) clearBuffer
{
	buffer = @"";
}

- (void) parse
{
	
	unsigned int bufferLength = [buffer length];
	NSRange searchRange = NSMakeRange(0, bufferLength);
	NSRange matchRange;
	NSMutableArray* result = nil;

	while (searchRange.location < bufferLength)
	{
		matchRange = [buffer rangeOfRegex:MESSAGE_REGEX inRange:searchRange];

		if (matchRange.location == NSNotFound)
		{
			break;
		}
		else
		{
			// If the result array doesn't exist yet, create it.
			if (result == nil)
				result = [NSMutableArray array];
			NSArray* match = [buffer captureComponentsMatchedByRegex:MESSAGE_REGEX range:matchRange];
			[result addObject:[[CompilerMessage alloc]
				initWithFile: [match objectAtIndex:1]
				row: [[match objectAtIndex:2] integerValue]
				column: [[match objectAtIndex:3] integerValue]
				type: [match objectAtIndex:4]
				descriptionText: [match objectAtIndex:5]
				lineOfCode: [match objectAtIndex:6]
			]];
			searchRange.location = matchRange.location + matchRange.length;
			searchRange.length = bufferLength - searchRange.location;
		}
	}

	if (result != nil)
	{
		// Remove the matched stuff from the buffer.
		buffer = [buffer substringWithRange:searchRange];

		// Notify subscribers that new messages have been parsed.
		[[NSNotificationCenter defaultCenter] postNotificationName:@"resultsAvailable" object:self userInfo:[NSDictionary dictionaryWithObject:result forKey:@"results"]];
	}
}

@end
