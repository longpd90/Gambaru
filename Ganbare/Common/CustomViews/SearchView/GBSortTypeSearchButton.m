//
//  GBSortTypeSearchButton.m
//  Ganbare
//
//  Created by Phung Long on 9/14/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBSortTypeSearchButton.h"

@implementation GBSortTypeSearchButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupInterface];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self setupInterface];
}

- (void)setupInterface {
    if (!self.selected) {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:kGBGlobalGrayColor forState:UIControlStateNormal];
        [self setTitleColor:kGBGlobalGrayColor forState:UIControlStateSelected];
        self.layer.borderColor = kGBGlobalGrayColor.CGColor;
        self.layer.borderWidth = 1;
        
    } else {
        self.backgroundColor = kGBGlobalGrayColor;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0;
    }
    
    if (self.tag == 0) {
        self.layer.cornerRadius = 18;
    }
    if (self.tag == 1) {
        self.layer.cornerRadius = 4;
    }
}

@end
