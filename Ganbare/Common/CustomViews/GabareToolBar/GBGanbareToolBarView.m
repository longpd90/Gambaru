//
//  GBGanbareToolBarView.m
//  Ganbare
//
//  Created by Phung Long on 9/7/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGanbareToolBarView.h"

@implementation GBGanbareToolBarView

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSBundle mainBundle] loadNibNamed:@"GBGanbareToolBarView" owner:self options:nil];
    [self addSubview:self.view];
    
    _gambareButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    // you probably want to center it
    _gambareButton.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
    [_gambareButton setTitle: @"GANBARE\nとは？" forState: UIControlStateNormal];
    if (![kGBTotalGanbareWithCommasValue isEqualToString:@""] ||
        kGBUserID == nil) {
        self.totalGanbareLabel.text = kGBTotalGanbareWithCommasValue;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(totalGanbareChange:) name:kGBUpdateTotalGabareNotification object:nil];

}

- (IBAction)signupButtonClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoSignup" object:nil]; 
}

- (void)setSignupInterface {
    _ganbareButtonWidthContraint.constant = 120;
    _gabareButtonRightConstrait.constant = -45;
    _signupButton.hidden = YES;
    [_gambareButton setTitle: @"GANBAREとは？" forState: UIControlStateNormal];

}


#pragma mark - Private

- (void)totalGanbareChange:(NSNotification *)notification
{
    NSDictionary *totalGabareDic = notification.userInfo;
    _totalGanbareNumber = [[totalGabareDic objectForKey:@"totalGanbare"] intValue];
    self.totalGanbareLabel.text = [NSString stringWithFormat:@"%@GB",[[GBAlgorithm sharedAlgorithm] numberWithCommas:_totalGanbareNumber integerDigits:18]] ;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGBUpdateTotalGabareNotification object:nil];
}

@end
