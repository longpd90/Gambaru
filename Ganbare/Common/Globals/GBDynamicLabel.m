//
//  GBDynamicLabel.m
//  Ganbare
//
//  Created by Phung Long on 10/9/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBDynamicLabel.h"

@implementation GBDynamicLabel

- (void)awakeFromNib
{
    [super awakeFromNib];
    _defaultSize = - 1.0;
//    [self applyGlobalFont];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _defaultSize = - 1.0;
//        [self applyGlobalFont];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (_defaultSize > 0) {
        self.font = [self.font fontWithSize:_defaultSize];
    }
    [self adjustFontSizeToFit];
}

- (void)adjustFontSizeToFit {
    UIFont *font = self.font;
    CGSize size = self.frame.size;
    for (CGFloat maxSize = self.font.pointSize; maxSize >= self.minimumScaleFactor * self.font.pointSize; maxSize -= 1.f) {
        font = [font fontWithSize:maxSize];
        CGSize constraintSize = CGSizeMake(size.width, MAXFLOAT);
        NSDictionary *attributes = @{ NSFontAttributeName: font};
        CGSize labelSize = [self.text boundingRectWithSize:constraintSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
        if(labelSize.width <= size.width - 5) {
            self.font = font;
            [self setNeedsLayout];
            break;
        }
    }
    self.font = font;
    [self setNeedsLayout];
}

@end
