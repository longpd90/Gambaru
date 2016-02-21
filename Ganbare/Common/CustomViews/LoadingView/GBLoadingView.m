//
//  GBLoadingView.m
//  Ganbare
//
//  Created by Phung Long on 10/5/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBLoadingView.h"

@interface GBLoadingView ()

@property (strong, nonatomic) UIWindow *keyWindow;

@end

@implementation GBLoadingView

- (instancetype)initHUDView {
    _keyWindow = [[UIApplication sharedApplication] keyWindow];
    self = [super initWithFrame:_keyWindow.frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30.0, 30.0)];
        [self.indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicatorView.center = self.center;
//        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
//        
//        for (int i = 1; i < 33; i++) {
//            NSString *imageName = [NSString stringWithFormat:@"common_loader_small_000%d", i];
//            if (i > 9) {
//                imageName = [NSString stringWithFormat:@"common_loader_small_00%d", i];
//            }
//            [imageArray addObject:[UIImage imageNamed:imageName]];
//        }
//        
//        self.indicatorImageView.animationImages = imageArray;
        [self.indicatorView startAnimating];
        [self addSubview:self.indicatorView];
    }
    return self;
}

- (void)showIndicator {
    [_keyWindow addSubview:self];
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations: ^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)hideIndicator {
    [UIView animateWithDuration:.2 animations: ^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.alpha = 0.0;
    } completion: ^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

@end
