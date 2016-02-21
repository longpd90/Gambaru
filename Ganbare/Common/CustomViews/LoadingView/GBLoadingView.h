//
//  GBLoadingView.h
//  Ganbare
//
//  Created by Phung Long on 10/5/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBLoadingView : UIView

@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
- (instancetype)initHUDView;
- (void)showIndicator;
- (void)hideIndicator;

@end
