//
//  GanbareCommentView.m
//  Ganbare
//
//  Created by Phung Long on 9/28/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGanbareCommentView.h"

@interface GBGanbareCommentView ()

@property (strong, nonatomic) UIImage *backgroundImage;
@end

@implementation GBGanbareCommentView

- (id)initWithMode:(GBCommentMode )mode {
    self = [super init];
    if (self) {
        _mode = mode;
        [self initialization];
    }
    return self;
}

- (void)initialization {
    if (self.mode == GBCommentModePolygon) {
        self.frame = CGRectMake(0, 0, 50, 40);
        _backgroundImage = [UIImage imageNamed:@"ganbare-popup-polygon-stype-icon"];
    } else {
        self.frame = CGRectMake(0, 0, 50, 32);
         _backgroundImage = [UIImage imageNamed:@"ganbare-popup-comment-stype-icon"];
    }
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.frame];
    imageview.image = _backgroundImage;
    [self addSubview:imageview];
}

@end
