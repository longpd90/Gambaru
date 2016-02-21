//
//  GBGambareStatusView.h
//  Ganbare
//
//  Created by Phung Long on 9/4/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GBGanbareStatusView : UIView
@property (assign, nonatomic) NSInteger totalGanbareNumber;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet GBDynamicLabel *ourMissionLabel;
@property (weak, nonatomic) IBOutlet GBDynamicLabel *ganbareTotalNumber;
- (IBAction)ourMissionButtonClicked:(id)sender;
- (void)setOurMissionRedStyle;
@end
