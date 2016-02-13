//
//  keyCollectionViewCell.m
//  Calculator
//
//  Created by Ahmed Elassuty on 2/9/16.
//  Copyright © 2016 Robusta. All rights reserved.
//

#import "KeyCollectionViewCell.h"

@implementation KeyCollectionViewCell

-(void) constructCell:(NSInteger) itemNumber width:(CGFloat) width {
    _roundedView.layer.cornerRadius = width/2.0;
    
    ([KeyCollectionViewCell isOperationKey:itemNumber]) ?
    [self operationKey: itemNumber]:[self  numberKey: itemNumber];
}

+(BOOL) isOperationKey:(NSInteger) itemNumber {
    return ((itemNumber + 1) % 4 == 0) || itemNumber == 14;
}

-(void) operationKey:(NSInteger) itemNumber {
    const NSString* operators = @"   +   -   ÷  =x";
    // Orange Background
    UIColor *backgroundColor = (itemNumber == 14) ?
        backgroundColor = [UIColor colorWithRed:39/255.0f
                                        green:44/255.0f
                                        blue:93/255.0f
                                        alpha:1.f]
                            : [UIColor colorWithRed:245/255.0f
                                        green:166/255.0f
                                        blue:35/255.0f
                                        alpha:1.f];
    
    unichar operator = [operators characterAtIndex:itemNumber];
    _valueLabel.text = [NSString stringWithFormat:@"%C", operator];
    
    _roundedView.backgroundColor = backgroundColor;
    _valueLabel.textColor = [UIColor whiteColor];
}

-(void) numberKey:(NSInteger) itemNumber {
    // View
    const NSString* numbers = @"789 456 123 0.";

    _roundedView.layer.borderWidth = 1;
    _roundedView.layer.borderColor = [UIColor colorWithRed:126/255.0f
                                                     green:211/255.0f
                                                      blue:33/255.0f
                                                     alpha:1.f].CGColor;
    // Label
    unichar number = [numbers characterAtIndex:itemNumber];
    _valueLabel.text = [NSString stringWithFormat:@"%C", number];
}

@end
