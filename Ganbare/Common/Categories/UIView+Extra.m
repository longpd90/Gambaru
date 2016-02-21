//
//  UIView+Extra.m
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "UIView+Extra.h"

@implementation UIView (Extra)

- (void)setPosition:(CGPoint)position {
    self.frame = CGRectMake(position.x, position.y, self.frame.size.width, self.frame.size.height);
}

- (CGPoint)position {
    return self.frame.origin;
}

- (CGPoint)centerOfView {
    return CGPointMake(roundf(self.width / 2), roundf(self.height / 2));
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width {
    CGRect newRect = self.frame;
    newRect.size.width = width;
    self.frame = newRect;
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height {
    CGRect newRect = self.frame;
    newRect.size.height = height;
    self.frame = newRect;
}

- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}

- (void)setX:(CGFloat)x {
    CGRect newRect = self.frame;
    newRect.origin.x = x;
    self.frame = newRect;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect newRect = self.frame;
    newRect.origin.y = y;
    self.frame = newRect;
}

- (CGFloat)bottomYPoint {
    return self.y + self.height;
}

- (CGRect)zeroPositionFrame {
    return CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)rightXPoint {
    return self.x + self.width;
}

+ (id)loadFromNibNamed:(NSString *)nibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
    return [nib objectAtIndex:0];
}

@end
