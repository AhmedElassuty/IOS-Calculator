//
//  ViewController.h
//  Calculator
//
//  Created by Ahmed Elassuty on 2/8/16.
//  Copyright © 2016 Robusta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property IBOutlet UICollectionView* collectionView;
@property IBOutlet UIView* resultView;
@property IBOutlet UIView* operationView;
@property IBOutlet UILabel* operationLabel;
@property IBOutlet UILabel* firstNumberLabel;
@property IBOutlet UILabel* secondNumberLabel;

@end

