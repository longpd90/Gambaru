//
//  GBNoInternetView.h
//  Ganbare
//
//  Created by Phung Long on 10/22/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBNoInternetView : UIView
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIButton *retryButton;

- (instancetype)initWithTarget:(id)target selector:(SEL)action;
- (void)show;
- (void)hide;
@end
