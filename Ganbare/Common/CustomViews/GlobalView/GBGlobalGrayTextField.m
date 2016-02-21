//
//  GBGlobalGrayTextField.m
//  Ganbare
//
//  Created by Phung Long on 9/8/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGlobalGrayTextField.h"

@implementation GBGlobalGrayTextField


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupInterface];

}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInterface];
    }
    return self;
}

- (void)setupInterface {
//    self.backgroundColor = kGBGlobalGrayColor;
//    self.layer.cornerRadius = 3;
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowRadius = 3;
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    bounds.size.width = bounds.size.width - 20.0f;
    if (self.tag == 1) {
        return CGRectInset(bounds, 10, 5);

    }
    return CGRectInset(bounds, 10, 8);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    bounds.size.width = bounds.size.width - 20.0f;
    if (self.tag == 1) {
        return CGRectInset(bounds, 10, 5);
    }
    return CGRectInset(bounds, 10, 8);
}

@end
