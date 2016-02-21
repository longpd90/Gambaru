//
//  GBGanbareTableViewCell.h
//  Ganbare
//
//  Created by Phung Long on 9/7/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBGanbareEntity.h"
#import "GBWebImage.h"
#import "GBGanbareContentTextView.h"

typedef enum {
    GBGanbareTableViewCellModeNormal = 0,
    GBGanbareTableViewCellModeVisitor
} GBGanbareTableViewCellMode;

@interface GBGanbareTableViewCell : UITableViewCell
@property (nonatomic) GBGanbareTableViewCellMode mode;
@property (strong, nonatomic) GBGanbareEntity *ganbareModel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiredDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet GBDynamicLabel *ganbareNumberLabel;
@property (weak, nonatomic) IBOutlet GBWebImage *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UIButton *ganbareButton;
@property (weak, nonatomic) IBOutlet GBWebImage *ganbareImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeUserButton;
@property (weak, nonatomic) IBOutlet UIButton *pinGanbareButton;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIView *ganbareContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet GBGanbareContentTextView *ganbareContentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *ganbareBackgroundEffectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *yellowBackgroundImageview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ganbareButtonRightConstraint;

- (IBAction)likeUserButtonClicked:(id)sender;
- (IBAction)pinGanbareButtonClicked:(id)sender;
- (IBAction)ganbareButtonClicked:(id)sender;
- (void)setBackgroundEffect;
- (void)setUserGanbareEffect;
@end
