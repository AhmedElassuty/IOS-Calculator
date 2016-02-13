//
//  keyCollectionViewCell.h
//  Calculator
//
//  Created by Ahmed Elassuty on 2/9/16.
//  Copyright © 2016 Robusta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyCollectionViewCell : UICollectionViewCell

@property IBOutlet UILabel* valueLabel;
@property IBOutlet UIView* roundedView;


-(void) constructCell:(NSInteger) itemNumber width:(CGFloat) width;
+(BOOL) isOperationKey:(NSInteger) itemNumber;
@end
