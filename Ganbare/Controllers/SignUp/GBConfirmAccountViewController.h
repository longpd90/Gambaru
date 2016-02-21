//
//  GBConfirmAccountViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/8/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseViewController.h"
#import "GBGlobalLabel.h"
#import "GBGanbareToolBarView.h"
#import "GBUserEntity.h"

@interface GBConfirmAccountViewController : GBBaseViewController

@property (strong, nonatomic) GBUserEntity *userEntity;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet GBGanbareToolBarView *ganbareToolbarView;
@property (weak, nonatomic) IBOutlet UILabel *mailAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginIDLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
- (IBAction)confirmButtonClicked:(id)sender;
- (IBAction)gobackButtonClicked:(id)sender;

@end
