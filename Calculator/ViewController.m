//
//  ViewController.m
//  Calculator
//
//  Created by Ahmed Elassuty on 2/8/16.
//  Copyright © 2016 Robusta. All rights reserved.
//

#import "ViewController.h"
#import "KeyCollectionViewCell.h"
#import "UILabel+Utils.h"

@interface ViewController ()

@property BOOL isOperationSelected;
@property NSString* lastAnswer;

@end

@implementation ViewController

-(void)viewDidLayoutSubviews{
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(toggleUndoTip) withObject:nil afterDelay:1.f];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _operationView.layer.cornerRadius = 15;
    _operationView.layer.borderWidth = 1;
    _operationView.layer.borderColor = [UIColor colorWithRed:151/255.0f
                                                       green:151/255.0f
                                                        blue:151/255.0f
                                                       alpha:1.f].CGColor;

    // Prepare collection view layout
    UICollectionViewFlowLayout* layout = [UICollectionViewFlowLayout new];
    layout.sectionInset = UIEdgeInsetsMake(4,8,4,8);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    _collectionView.collectionViewLayout = layout;
    
    // Add undo recognizer to the second label
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(undoCharacterSwipeGesture:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [_resultView addGestureRecognizer:swipe];
    [_resultView setUserInteractionEnabled:YES];
}

- (void)undoCharacterSwipeGesture:(UIGestureRecognizer *)recognizer {
    NSString *temStr;
    if ((temStr = _secondNumberLabel.text).length != 0)
        _secondNumberLabel.text = [temStr substringToIndex:[temStr length]-1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewFlowLayout* layout = (UICollectionViewFlowLayout *)[collectionView collectionViewLayout];
    CGFloat width = (collectionView.bounds.size.width -  [layout minimumInteritemSpacing] * 3.0 - [layout sectionInset].right - [layout sectionInset].left)/4;
    CGFloat height = (collectionView.bounds.size.height - [layout sectionInset].top * 4. - [layout sectionInset].bottom * 4.)/4;
    if (width < height) {
        return CGSizeMake(width, width);
    }
    return CGSizeMake(height, height);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KeyCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KeyCollectionViewCell" forIndexPath:indexPath];
    [(KeyCollectionViewCell *)cell constructCell:indexPath.item + (indexPath.section * 4) width:cell.bounds.size.width];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    KeyCollectionViewCell* cell = (KeyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSInteger itemNumber = indexPath.item + (indexPath.section * 4);
    
    // Animation
    cell.transform = CGAffineTransformMakeScale(1.2,1.2);
    [UIView animateWithDuration:.5
            delay:0
            options:(UIViewAnimationOptionAllowUserInteraction)
        animations:^{
            cell.transform = CGAffineTransformIdentity;
        }
        completion:nil
     ];

    // Functionality
    if([KeyCollectionViewCell isOperationKey:itemNumber]){
        if (!_secondNumberLabel.isEmpty || !_firstNumberLabel.isEmpty) {
            // Equal operation
            if (itemNumber == 14) {
                // select operation !!
                if (_operationLabel.isEmpty || _secondNumberLabel.isEmpty || _firstNumberLabel.isEmpty) return;
                
                // Perform calculations

                // Replace operations signs
                NSString *modifiedOperationString = [_operationLabel.text stringByReplacingOccurrencesOfString:@"÷" withString:@"/"];
                modifiedOperationString = [modifiedOperationString stringByReplacingOccurrencesOfString:@"x" withString:@"*"];
                
                // Prepare Formula to be evaluated
                NSString* formula = [_firstNumberLabel.text stringByAppendingString:modifiedOperationString];
                formula = [formula stringByAppendingString:@"("];
                NSDecimalNumber* secondOperand = [NSDecimalNumber decimalNumberWithString:_secondNumberLabel.text];
                formula = [formula stringByAppendingString: secondOperand.stringValue];
                formula = [formula stringByAppendingString:@"*1.0)"];

                // Execute expression
                NSExpression *expression = [NSExpression expressionWithFormat:formula];
                NSDecimalNumber *result = [NSDecimalNumber decimalNumberWithDecimal:[[expression expressionValueWithObject:nil context:nil] decimalValue]];
                
                // Update view
                _firstNumberLabel.text = result.stringValue;
                _secondNumberLabel.text = @"";
                _operationLabel.text = @"";
                return;
            }
            // Other operations
            _operationLabel.text = cell.valueLabel.text;
            if (_firstNumberLabel.isEmpty){
                _firstNumberLabel.text = _secondNumberLabel.text;
                _secondNumberLabel.text = @"";
            }
        }
    } else {
        // Clear answer if no operation otherwise use the answer
        if (_operationLabel.isEmpty) _firstNumberLabel.text = @"";
        
        // handle multiple dots
        if ([_secondNumberLabel.text containsString:@"."] && [cell.valueLabel.text  isEqual:@"."]) return;

        // Handle leading zeros
        if ([_secondNumberLabel.text hasPrefix:@"0"]) {
            if ([cell.valueLabel.text isEqual:@"0"]) return;
            _secondNumberLabel.text = @"";
        }

        _secondNumberLabel.text = [_secondNumberLabel.text  stringByAppendingString:cell.valueLabel.text];
    }
}

-(void) toggleUndoTip {
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [_resultView addSubview:visualEffectView];
    visualEffectView.frame = _resultView.bounds;
    
    UILabel* tip = [[UILabel alloc] initWithFrame:visualEffectView.bounds];
    tip.textAlignment = NSTextAlignmentCenter;
    tip.text = @"Swipe left to undo";
    tip.textColor = [UIColor whiteColor];

    [visualEffectView addSubview:tip];
    
    [visualEffectView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [tip setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ];

    [UIView animateWithDuration:3.f animations:^{
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:5.f animations:^{
            [visualEffectView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [visualEffectView removeFromSuperview];
        }];
    }];
}

@end