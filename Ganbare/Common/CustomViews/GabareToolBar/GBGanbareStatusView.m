//
//  GBGambareStatusView.m
//  Ganbare
//
//  Created by Phung Long on 9/4/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGanbareStatusView.h"

@implementation GBGanbareStatusView

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSBundle mainBundle] loadNibNamed:@"GBGanbareStatusView" owner:self options:nil];
    [self addSubview:self.view];
    self.ourMissionLabel.text = @"Our mission";
    self.ganbareTotalNumber.adjustsFontSizeToFitWidth = YES;
    self.ganbareTotalNumber.text = kGBTotalGanbareWithCommasValue;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(totalGanbareChange:) name:kGBUpdateTotalGabareNotification object:nil];
}

- (IBAction)ourMissionButtonClicked:(id)sender {
}

#pragma mark - Private

- (void)totalGanbareChange:(NSNotification *)notification
{
    NSDictionary *totalGabareDic = notification.userInfo;
    _totalGanbareNumber = [[totalGabareDic objectForKey:@"totalGanbare"] intValue];
    self.ganbareTotalNumber.text = [NSString stringWithFormat:@"%@GB",[[GBAlgorithm sharedAlgorithm] numberWithCommas:_totalGanbareNumber integerDigits:18]] ;
    [kGBUserDefaults setObject:[NSString stringWithFormat:@"%018ldGB",(long)_totalGanbareNumber] forKey:kGBTotalGanbareKey];
    [kGBUserDefaults setObject:[NSString stringWithFormat:@"%022ldGB",(long)_totalGanbareNumber] forKey:kGBTotal22NumberGanbareKey];
    [kGBUserDefaults setObject:[NSString stringWithFormat:@"%@GB",[[GBAlgorithm sharedAlgorithm] numberWithCommas:_totalGanbareNumber integerDigits:18]] forKey:kGBTotalGanbareWithCommasKey];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGBUpdateTotalGabareNotification object:nil];
}

- (void)setOurMissionRedStyle {
    self.ourMissionLabel.textColor = [UIColor redColor];
    self.arrowImageView.image = [UIImage imageNamed:@"right-arrow-icon-red-style"];
}
@end
