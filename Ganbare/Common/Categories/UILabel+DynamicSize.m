//
//  UILabel+DynamicSize.m
//  Ganbare
//
//  Created by Phung Long on 10/9/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "UILabel+DynamicSize.h"

@implementation UILabel (DynamicSize)

-(float)resizeToFit{
    float height = [self expectedHeight];
    CGRect newFrame = [self frame];
    newFrame.size.height = height;
    [self setFrame:newFrame];
    return newFrame.origin.y + newFrame.size.height;
}

-(float)expectedHeight{
    [self setNumberOfLines:0];
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width,MAXFLOAT);
    NSDictionary *attributes = @{ NSFontAttributeName:[self font]};
    CGSize expectedLabelSize = [self.text boundingRectWithSize:maximumLabelSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    return expectedLabelSize.height;
}

@end
