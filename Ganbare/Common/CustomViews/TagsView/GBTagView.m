//
//  GBTagView.m
//  Ganbare
//
//  Created by Phung Long on 9/30/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBTagView.h"

@implementation GBTagView

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = kGBPhotoPageTagBackgroudColor;
    }
    return self;
}

- (void)setTagName:(NSString *)tagName {
    _tagName = tagName;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:GBGlobalNormalFontName size:14]};
    UILabel *tagLabel = [UILabel new];
    tagLabel.text = [NSString stringWithFormat:@"#%@",tagName];
    tagLabel.textColor = [UIColor blackColor];
    tagLabel.font = [UIFont fontWithName:GBGlobalNormalFontName size:14];
    int labelWidth = [tagName sizeWithAttributes:attributes].width + 10;
    if (labelWidth >= kMaxWidthTagLabel) {
        labelWidth = kMaxWidthTagLabel;
    }
    tagLabel.frame = CGRectMake(4, 0, labelWidth, 25);
    [self addSubview:tagLabel];
    
    UIImage *cancelImage = [UIImage imageNamed:@"cancel-ganbare-icon"];
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(tagButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setBackgroundImage:cancelImage
                        forState:UIControlStateNormal];
    tagButton.frame = CGRectMake(tagLabel.width + 5, 5, 15, 15);
    tagButton.backgroundColor = [UIColor blueColor];
    [self addSubview:tagButton];
    self.frame = CGRectMake(0, 0, labelWidth + 25, 25);
}

- (void)tagButtonTouch {
    if (self.delegate && [self.delegate respondsToSelector:@selector(removeTagsWithIndex:)]) {
        [self.delegate removeTagsWithIndex:_index];
    }
}

@end
