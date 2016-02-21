//
//  GBEditProfileViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/16/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseViewController.h"
#import "GBUserEntity.h"
#import "GBWebImage.h"

@interface GBEditProfileViewController : GBBaseViewController
@property (nonatomic, strong)GBUserEntity *userEntity;
@property (weak, nonatomic) IBOutlet UIButton *userNameEditButton;
@property (weak, nonatomic) IBOutlet UIButton *profileEditButton;
@property (weak, nonatomic) IBOutlet GBWebImage *userAvatarImageView;
@property (weak, nonatomic) IBOutlet GBWebImage *backgroundAvatarImageView;
@property (weak, nonatomic) IBOutlet UITextView *userNameTextView;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@property (weak, nonatomic) IBOutlet UITextView *profileTextView;
- (IBAction)saveButtonClicked:(id)sender;
- (IBAction)editAvatarButtonClicked:(id)sender;
- (IBAction)editBackgroundButtonClicked:(id)sender;
- (IBAction)editNameButtonClicked:(id)sender;
- (IBAction)editProfileButtonClicked:(id)sender;
- (IBAction)editSNSButtonClicked:(id)sender;

@end
