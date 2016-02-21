//
//  GBGlobalBorderView.m
//  Ganbare
//
//  Created by Phung Long on 9/14/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGlobalBorderView.h"

@implementation GBGlobalBorderView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

@end
