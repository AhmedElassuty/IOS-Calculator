//
//  UILabel+Utils.m
//  Calculator
//
//  Created by Ahmed Elassuty on 2/12/16.
//  Copyright © 2016 Robusta. All rights reserved.
//

#import "UILabel+Utils.h"

@implementation UILabel (Utils)

-(BOOL) isEmpty {
    return (self.text.length == 0);
}

-(NSString *) replace:(NSString *)toBeReplaced with:(NSString *) withString {
    return [self.text stringByReplacingOccurrencesOfString:toBeReplaced withString:withString];
}

@end