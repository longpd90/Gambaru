//
//  GBSortTypeGanbareUserButton.m
//  Ganbare
//
//  Created by Phung Long on 9/11/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBSortTypeGanbareUserButton.h"

@implementation GBSortTypeGanbareUserButton

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
        self.backgroundColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.layer.borderWidth = 1;
        
    } else {
        self.backgroundColor = [UIColor clearColor];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0;
    }
}

@end
