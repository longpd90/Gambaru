//
//  GBNoInternetView.m
//  Ganbare
//
//  Created by Phung Long on 10/22/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBNoInternetView.h"

@implementation GBNoInternetView

- (instancetype)initWithTarget:(id)target selector:(SEL)action {
    CGRect frame = [UIApplication sharedApplication].keyWindow.frame;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:245.0 / 255.0
                                               green:250.0 / 255.0
                                                blue:250.0 / 255.0
                                               alpha:1];
        
        float centerX = CGRectGetMidX(frame);
        float centerY = CGRectGetMidY(frame);
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(centerX - 50.0, centerY - 100.0, 100.0, 100.0)];
        self.imageView.image = [UIImage imageNamed:@"error_pic_offline_02"];
        
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(centerX - 80.0, centerY + 20.0, 160.0, 50.0)];
        self.messageLabel.text = @"インターネット接続がオフラインのようです";
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.font = [UIFont systemFontOfSize:13.0];
        self.messageLabel.numberOfLines = 2;
        
        self.retryButton = [[UIButton alloc] initWithFrame:CGRectMake(40.0, CGRectGetMaxY(self.messageLabel.frame) + 30.0, CGRectGetWidth(frame) - 80.0, 35.0)];
        [self.retryButton setTitle:@"もう一度読み込む" forState:UIControlStateNormal];
        [self.retryButton addTarget:target
                             action:action
                   forControlEvents:UIControlEventTouchUpInside];
        [self.retryButton addTarget:self
                             action:@selector(hide)
                   forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.imageView];
        [self addSubview:self.messageLabel];
        [self addSubview:self.retryButton];
    }
    return self;
}

- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations: ^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)hide {
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
