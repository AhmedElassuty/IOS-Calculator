//
//  ScientificKeyCollectionViewCell.h
//  Calculator
//
//  Created by Ahmed Elassuty on 2/13/16.
//  Copyright © 2016 Robusta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScientificKeyCollectionViewCell : UICollectionViewCell

@property IBOutlet UILabel* label;

-(void) constructCell:(NSInteger) itemNumber;

@end
