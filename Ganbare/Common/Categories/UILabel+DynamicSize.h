//
//  UILabel+DynamicSize.h
//  Ganbare
//
//  Created by Phung Long on 10/9/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DynamicSize)

- (float)resizeToFit;
- (float)expectedHeight;

@end
