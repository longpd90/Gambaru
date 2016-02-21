//
//  Macros.h
//  Ganbare
//
//  Created by Phung Long on 9/4/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#ifndef Ganbare_Macros_h
#define Ganbare_Macros_h

// const

#define kGBGanbareTableViewCellHeight       280
#define kMaxGanbareNumberInView 30

//color
#define kGBGlobalGrayColor            [UIColor colorWithRed:166.0 / 255.0 green:166.0 / 255.0 blue:166.0 / 255.0 alpha:1]
#define kGBColorWhite           [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]

// Notification

#define kGBUpdateTotalGabareNotification          @"kGBUpdateTotalGabareNotification"
#define kGBItemWasChangedNotification           @"kGBItemWasChangedNotification"
#define kGBWasAddedGanbareNotification           @"kGBWasAddedGanbareNotification"

// User default key
#define kGBShowTipKey               @"kGBShowTipKey"
#define kGBAuthTokenKey                 @"kGBAuthTokenKey"
#define kGBUserIDKey                    @"kGBUserIDKey"
#define kGBLoginIDKey                    @"kGBLoginIDKey"
#define kGBUserNameKey                    @"kGBUserNameKey"
#define kGBLoginPassWordKey                @"kGBLoginPassWordKey"
#define kGBMailAddressKey                    @"kGBMailAddressKey"
#define kGBDoNotShowTipValue                @"kGBDoNotShowTipValue"
#define kGBTotalGanbareKey                @"kGBTotalGanbareKey"
#define kGBTotal22NumberGanbareKey                @"kGBTotal22NumberGanbareKey"
#define kGBTotalGanbareWithCommasKey                @"kGBTotalGanbareWithCommasKey"


// user default value
#define kGBUserDefaults                 [NSUserDefaults standardUserDefaults]
#define kGBShowTip                     [kGBUserDefaults objectForKey:kGBShowTipKey]
#define kGBAuthToken                  [kGBUserDefaults objectForKey:kGBAuthTokenKey]
#define kGBUserID                     [kGBUserDefaults objectForKey:kGBUserIDKey]
#define kGBLoginID                     [kGBUserDefaults objectForKey:kGBLoginIDKey]
#define kGBUserName                     [kGBUserDefaults objectForKey:kGBUserNameKey]
#define kGBMailAddress                     [kGBUserDefaults objectForKey:kGBMailAddressKey]
#define kGBTotalGanbareValue               [kGBUserDefaults objectForKey:kGBTotalGanbareKey]
#define kGBTotal22NumberGanbareValue               [kGBUserDefaults objectForKey:kGBTotal22NumberGanbareKey]
#define kGBTotalGanbareWithCommasValue               [kGBUserDefaults objectForKey:kGBTotalGanbareWithCommasKey]

#define kGBLoginPassWord               [kGBUserDefaults objectForKey:kGBLoginPassWordKey]
#define kGBPhotoPageTagBackgroudColor           [UIColor colorWithRed:237/255.0 green:242/255.0 blue:245/255.0 alpha:1]

// typedef
typedef enum GBCropImageType : NSInteger {
    GBCropImageTypeRectangle = 0,
    GBCropImageTypeSquare
} GBCropImageType;

typedef enum {
    GBGanbareEditModeNew = 0,
    GBGanbareEditModeEdit,
} GBGanbareEditMode;

enum Sections {
    kInformations = 0,
    kSettings,
    kSectionsCount
};

enum Informations {
    kGanbareIntroRow = 0,
    kWebSiteRow,
    kNotificationRow,
    kPrivacyPolicyRow,
    kCompanyRow,
    kQuestionRow,
    kContactUsRow,
    kInformationsCount
};

enum Settings {
    kChangeUserInfoRow,
    kNotificationSettingsRow,
    kScurityLanguageSettingsRow,
    kSNSSettingsRow,
    kSettingsCount
};

enum {
    GBTakePhotoModeCamera = 0,
    GBTakePhotoModeLibrary,
    GBTakePhotoModeDelete
} ;

#endif
