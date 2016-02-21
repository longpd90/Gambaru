//
//  UIView+Extra.h
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Extra)

@property (nonatomic, getter=position, setter = setPosition:) CGPoint position;
@property (nonatomic, getter=width, setter = setWidth:) CGFloat width;
@property (nonatomic, getter=height, setter = setHeight:) CGFloat height;
@property (nonatomic, getter=y, setter = setY:) CGFloat y;
@property (nonatomic, getter=x, setter = setX:) CGFloat x;

- (CGFloat) width;
- (void)setWidth:(CGFloat)width;
- (CGFloat) height;
- (void)setHeight:(CGFloat)height;
- (CGFloat) x;
- (void)setX:(CGFloat)x;
- (CGFloat) y;
- (void)setY:(CGFloat)y;

- (CGPoint) centerOfView;
- (CGFloat) bottomYPoint;
- (CGFloat) rightXPoint;
- (CGRect) zeroPositionFrame;
+ (id)loadFromNibNamed:(NSString *)nibName;
@end
