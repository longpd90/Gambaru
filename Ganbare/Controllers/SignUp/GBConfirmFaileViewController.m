//
//  GBConfirmFaileViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/9/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBConfirmFaileViewController.h"

@interface GBConfirmFaileViewController ()

@end

@implementation GBConfirmFaileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ganbareToolbarView setSignupInterface];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - call api

- (void)callAPILogin {
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:kGBMailAddress forKey:@"email"];
    [params setObject:@"1" forKey:@"loginType"];
    [params setObject:[kGBLoginPassWord encyptMD5] forKey:@"password"];
    [[GBRequestManager sharedManager] asyncPOST:[NSString stringFromConst:gbURLSessions] parameters:params isShowLoadingView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            NSString *token = [data objectForKey:@"token"];
            if (token) {
                [[GBRequestManager sharedManager] setToken:token];
                [kGBUserDefaults setValue:token forKey:kGBAuthTokenKey];
            }
            NSString *userID = [data objectForKey:@"userId"];
            if (userID.length > 0) {
                [kGBUserDefaults setObject:userID forKey:kGBUserIDKey];
            }
            [kGBUserDefaults synchronize];

            NSLog(@"token :%@, userid :%@",kGBAuthToken,kGBUserID);
            [self performSegueWithIdentifier:@"showConfirmSuccessSegue" sender:self];
        } else {
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (IBAction)checkConfirmButtonClicked:(id)sender {
    [self callAPILogin];

}
@end
