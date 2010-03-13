//
//  OakTextViewProxy.h
//  TMAS3ComplierErrorsPlugin
//
//  Created by Eric Eldredge on 3/11/10.
//  Copyright 2010 HZDG. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface OakTextViewProxy : NSObject 
{
	@private id oakTextView;
}
+ (OakTextViewProxy*)proxyForCurrentOakTextView;

- (id)initWithOakTextView:(id)anOakTextView;

@end
