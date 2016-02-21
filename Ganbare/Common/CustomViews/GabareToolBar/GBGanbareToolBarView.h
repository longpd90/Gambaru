//
//  GBGanbareToolBarView.h
//  Ganbare
//
//  Created by Phung Long on 9/7/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBGanbareToolBarView;
@protocol GBGanbareToolBarViewDelegate <NSObject>

- (void)toolbarSignupButtonclick:(GBGanbareToolBarView *)view ;

@end

@interface GBGanbareToolBarView : UIView
@property (weak, nonatomic)id<GBGanbareToolBarViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (assign, nonatomic) NSInteger totalGanbareNumber;
@property (weak, nonatomic) IBOutlet GBDynamicLabel *totalGanbareLabel;
@property (weak, nonatomic) IBOutlet UIButton *gambareButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *gabareButtonRightConstrait;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ganbareButtonWidthContraint;
- (IBAction)signupButtonClicked:(id)sender;
- (void)setSignupInterface;

@end
