//
//  GBMypageViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/4/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseTableViewController.h"
#import "GBSortTypeGanbareUserButton.h"
#import "GBWebImage.h"
#import "GBUserEntity.h"
#import "GBGanbareContentTextView.h"

typedef enum {
    GBGanbareModeNew = 0,
    GBGanbareModeHot,
    GBGanbareModeNoHot,
    GBGanbareModeExpiring,
    GBGanbareModeExpired
} GBGanbareMode;

typedef enum GBUserMode : NSInteger {
    GBUserModeMypage = 0,
    GBUserModeOtherUser
} GBUserMode;

typedef enum  {
    GBGetGanbareModeNormal = 0,
    GBGetGanbareModePin
} GBGetGanbareMode;


@interface GBUserViewController : GBBaseTableViewController
@property (assign, nonatomic) NSInteger ganbareSearchMode;
@property (strong, nonatomic) NSString *userID;
@property (weak, nonatomic) IBOutlet GBGanbareContentTextView *userProfileTextView;
@property (nonatomic) GBUserMode mode;
@property (nonatomic) GBGetGanbareMode getGanbareMode;
@property (nonatomic) GBGanbareEditMode ganbareEditMode;
@property (weak, nonatomic) IBOutlet UILabel *loginIdLabel;

@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (weak, nonatomic) IBOutlet UILabel *userGanbareLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *creatButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet GBSortTypeGanbareUserButton *hotButton;
@property (weak, nonatomic) IBOutlet GBSortTypeGanbareUserButton *noHotButton;
@property (weak, nonatomic) IBOutlet GBSortTypeGanbareUserButton *expiringButton;
@property (weak, nonatomic) IBOutlet GBSortTypeGanbareUserButton *sortNewButton;
@property (weak, nonatomic) IBOutlet GBWebImage *userAvatarImageView;
@property (weak, nonatomic) IBOutlet GBSortTypeGanbareUserButton *expiredButton;
@property (weak, nonatomic) IBOutlet GBWebImage *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *favaritedNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *sentPinNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *receviedPinNumberLabel;
@property (weak, nonatomic) IBOutlet GBDynamicLabel *sentganbareNumberLabel;
@property (weak, nonatomic) IBOutlet GBDynamicLabel *receivedGanbareNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;

- (IBAction)changeSource:(id)sender;
- (IBAction)editProfileButtonclicked:(id)sender;
- (IBAction)searchButtonClicked:(id)sender;
- (IBAction)creatButtonClicked:(id)sender;
- (IBAction)likeButtonClicked:(id)sender;
- (IBAction)piningGanbareButtonClicked:(id)sender;

@end
