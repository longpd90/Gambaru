//
//  GBMainMenuViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/9/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBMainMenuViewController.h"
#import "GBSettingsView.h"

enum GBTabbar {
    GBTabbarHome = 0,
    GBTabbarNotification,
    GBTabbarMypage,
    GBTabbarSettings
};

@interface GBMainMenuViewController ()<UITabBarControllerDelegate,UITabBarDelegate,GBSettingsViewDelegate>
@property (strong, nonatomic) GBSettingsView *settingsView;
@property (assign, nonatomic) BOOL isShowSettings;

@end

@implementation GBMainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
#pragma mark - tabbar controller

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([tabBarController.viewControllers indexOfObject:viewController] != GBTabbarSettings) {
        return YES;
    } else {
        return NO;
    }
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (_isShowSettings) {
        [self hiddenSettingMenu];
    }
    if(item.tag == GBTabbarSettings)
    {
        if (!_isShowSettings) {
            [self showSettingMenu] ;
        } else {
            [self hiddenSettingMenu];
        }
    }

}

- (void)showSettingMenu {
    if (!_settingsView) {
        _settingsView = [UIView loadFromNibNamed:@"GBSettingsView"];
        [self.view addSubview:_settingsView];
        _settingsView.delegate = self;
        _settingsView.width = self.view.width;
        _settingsView.height = self.tabBar.y - _settingsView.y;
//        _settingsView.height = self.view.height;
        
    }
    _settingsView.x = self.view.rightXPoint;
    [UIView animateWithDuration:0.2 animations: ^{
        _settingsView.x = self.view.rightXPoint - _settingsView.width;
        _isShowSettings = YES;
    }];

}

- (void)hiddenSettingMenu {
    
    [UIView animateWithDuration:0.2 animations:^{
        _settingsView.x = self.view.rightXPoint;
    } completion:^(BOOL finished) {
        _isShowSettings = NO;
    }];
}

#pragma mark - setting delegate

- (void)overlayViewTouched {
    [self hiddenSettingMenu];
}

- (void) signoutDelegate {
    [self callAPISignout];
}
#pragma mark - call api

- (void)callAPISignout {
    [[GBRequestManager sharedManager] asyncDELETE:[NSString stringWithFormat:@"%@%@",gbURLSessions,kGBAuthToken] parameters:nil isShowLoadingView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            [self signout];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)signout {
    [[GBRequestManager sharedManager] setToken:@""];
    [kGBUserDefaults setValue:@"" forKey:kGBAuthTokenKey];
    [kGBUserDefaults setObject:@"" forKey:kGBUserIDKey];
    [kGBUserDefaults setObject:@"" forKey:kGBShowTipKey];
    [kGBUserDefaults synchronize];
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *signinNavigationViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"GBNavigationSinginViewController"];
    [[UIApplication sharedApplication] keyWindow].rootViewController = signinNavigationViewController;
    [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
}

- (void)didSelectedIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == kInformations && indexPath.row == kGanbareIntroRow) {
        
    } else if (indexPath.section == kInformations && indexPath.row == kWebSiteRow) {
        
    } else if (indexPath.section == kInformations && indexPath.row == kNotificationRow) {
        
    } else if (indexPath.section == kInformations && indexPath.row == kPrivacyPolicyRow) {
        
    } else if (indexPath.section == kInformations && indexPath.row == kCompanyRow) {
        
    } else if (indexPath.section == kInformations && indexPath.row == kQuestionRow) {
        
    }else if (indexPath.section == kInformations && indexPath.row == kContactUsRow) {
        
    } else if (indexPath.section == kSettings && indexPath.row == kChangeUserInfoRow) {
        
    } else if (indexPath.section == kSettings && indexPath.row == kNotificationSettingsRow) {
        
    }else if (indexPath.section == kSettings && indexPath.row == kScurityLanguageSettingsRow) {
        
    }else if (indexPath.section == kSettings && indexPath.row == kSNSSettingsRow) {
        
    }
}

@end
