//
//  UILabel+Utils.h
//  Calculator
//
//  Created by Ahmed Elassuty on 2/12/16.
//  Copyright © 2016 Robusta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Utils)

-(BOOL) isEmpty;
-(NSString *) replace:(NSString *)toBereplaced with:(NSString *) withString;

@end
