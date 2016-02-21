//
//  GBGanbareContentTextView.m
//  Ganbare
//
//  Created by Phung Long on 10/20/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGanbareContentTextView.h"

@implementation GBGanbareContentTextView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupInterface];
}

- (void)setupInterface {
    self.editable = NO;
    self.selectable = YES;
    self.userInteractionEnabled = YES;
    self.dataDetectorTypes = UIDataDetectorTypeNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentInset = UIEdgeInsetsZero;
    self.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.contentOffset = CGPointZero;
    self.textContainerInset = UIEdgeInsetsZero;
    self.textContainer.lineFragmentPadding = 0;
}
@end
