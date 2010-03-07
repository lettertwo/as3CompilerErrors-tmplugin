//
//  CategoryCell.h
//  StandaloneView
//
//  Created by Matthew Tretter on 3/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CategoryCell : NSTextFieldCell {
	NSDictionary* textAttributes;
}

@property (retain) NSDictionary* textAttributes;

@end
