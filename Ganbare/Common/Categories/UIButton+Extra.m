//
//  UIButton+Extra.m
//  Ganbare
//
//  Created by Phung Long on 10/22/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "UIButton+Extra.h"

@implementation UIButton (Extra)

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
