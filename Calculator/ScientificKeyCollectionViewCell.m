//
//  ScientificKeyCollectionViewCell.m
//  Calculator
//
//  Created by Ahmed Elassuty on 2/13/16.
//  Copyright © 2016 Robusta. All rights reserved.
//

#import "ScientificKeyCollectionViewCell.h"

@implementation ScientificKeyCollectionViewCell

//-(instancetype) init

-(void) constructCell:(NSInteger) itemNumber {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor colorWithRed:139/255.0f
                                                     green:87/255.0f
                                                      blue:42/255.0f
                                                     alpha:1.f].CGColor;
    
    // [TODO] Labels should be changed to their scientific names
    // using const static NSArray for mapping
    // Prototyping
    NSArray *values = [NSArray arrayWithObjects:@"sin", @"cos", @"Exp", nil];


    if (itemNumber < 3) {
        _label.text = values[itemNumber];
        return;
    }
    
    _label.text = [NSString stringWithFormat:@"%ld", (long)itemNumber];
}

@end
