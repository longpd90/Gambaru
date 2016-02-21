//
//  GBSignupViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseViewController.h"
#import "GBGlobalGrayTextField.h"
#import "GBGanbareToolBarView.h"
#import "GBGanbareStatusView.h"

typedef enum {
    GBSigninModeEmail = 0,
    GBSigninModeFacebook,
    GBSigninModeGoogle,
    GBSigninModeTwitter
} GBSigninMode;

typedef enum {
    GBValidateModeLoginID = 0,
    GBValidateModeEmail
} GBValidateMode;

@interface GBSignupViewController : GBBaseViewController
@property (nonatomic) GBValidateMode validateMode;
@property (weak, nonatomic) IBOutlet GBGlobalGrayTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet GBGlobalGrayTextField *userNameTextField;
@property (weak, nonatomic) IBOutlet GBGlobalGrayTextField *mailAddressTextField;
@property (weak, nonatomic) IBOutlet GBGlobalGrayTextField *loginIDTextField;
@property (weak, nonatomic) IBOutlet GBGanbareToolBarView *gabareToolBarView;
@property (weak, nonatomic) IBOutlet UIButton *avatarButton;
@property (weak, nonatomic) IBOutlet UIButton *backgroundButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarButtonHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundButtonWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundButtonHeightConstraint;
@property (strong, nonatomic) IBOutletCollection(GBGlobalGrayTextField) NSArray *textFieldCollection;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIImageView *loginIDCheckImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordCheckImageView;
@property (weak, nonatomic) IBOutlet UIImageView *mailCheckImageView;
@property (weak, nonatomic) IBOutlet UIImageView *useNameCheckImageView;
@property (weak, nonatomic) IBOutlet UITableView *signupTableView;
@property (weak, nonatomic) IBOutlet UIView *signupHeaderView;

- (IBAction)confirmButtonClicked:(id)sender;
- (IBAction)updateAvatar:(id)sender;
- (IBAction)updateCoverPhoto:(id)sender;
- (IBAction)textFieldDidChange:(UITextField *)textField;

@end
