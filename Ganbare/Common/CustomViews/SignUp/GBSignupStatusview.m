//
//  GBSignupStatusview.m
//  Ganbare
//
//  Created by Phung Long on 9/8/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBSignupStatusview.h"

@implementation GBSignupStatusview

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSBundle mainBundle] loadNibNamed:@"GBSignupStatusview" owner:self options:nil];
    [self addSubview:self.view];
    [self setupColorStatusViews];
}

- (void)setupColorStatusViews {
    long int step = self.tag;

    switch (step) {
        case 1:
            self.registView.backgroundColor = [UIColor redColor];
            self.confirmView.backgroundColor = kGBGlobalGrayColor;
            self.finishView.backgroundColor = kGBGlobalGrayColor;
            self.tutorialView.backgroundColor = kGBGlobalGrayColor;
            self.ganbareView.backgroundColor = kGBGlobalGrayColor;
            break;
        case 2:
            self.registView.backgroundColor = kGBGlobalGrayColor;
            self.confirmView.backgroundColor = [UIColor redColor];
            self.finishView.backgroundColor = kGBGlobalGrayColor;
            self.tutorialView.backgroundColor = kGBGlobalGrayColor;
            self.ganbareView.backgroundColor = kGBGlobalGrayColor;
            break;
        case 3:
            self.registView.backgroundColor = kGBGlobalGrayColor;
            self.confirmView.backgroundColor = kGBGlobalGrayColor;
            self.finishView.backgroundColor = [UIColor redColor];
            self.tutorialView.backgroundColor = kGBGlobalGrayColor;
            self.ganbareView.backgroundColor = kGBGlobalGrayColor;
            break;
        case 4:
            self.registView.backgroundColor = kGBGlobalGrayColor;
            self.confirmView.backgroundColor = kGBGlobalGrayColor;
            self.finishView.backgroundColor = kGBGlobalGrayColor;
            self.tutorialView.backgroundColor = [UIColor redColor];
            self.ganbareView.backgroundColor = kGBGlobalGrayColor;
            break;
        case 5:
            self.registView.backgroundColor = kGBGlobalGrayColor;
            self.confirmView.backgroundColor = kGBGlobalGrayColor;
            self.finishView.backgroundColor = kGBGlobalGrayColor;
            self.tutorialView.backgroundColor = kGBGlobalGrayColor;
            self.ganbareView.backgroundColor = [UIColor redColor];
            break;
        default:
            break;
    }

}
@end
