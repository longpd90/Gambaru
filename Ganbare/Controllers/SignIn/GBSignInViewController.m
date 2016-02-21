//
//  GBSignInViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/9/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBSignInViewController.h"

@interface GBSignInViewController ()

@end

@implementation GBSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (kGBTotal22NumberGanbareValue != nil ) {
        self.totalGanbareLabel.text = kGBTotal22NumberGanbareValue;
    }
    [self pingToSever];
    _signInButton.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)ganbareButtonClicked:(id)sender {
}

- (IBAction)signinButtonClicked:(id)sender {
    [self.view endEditing:YES];
    [self callAPILogin];
}

#pragma mark - textfield 

- (BOOL) textFieldShouldClear:(UITextField *)textField{
    [_signInButton setEnabled:NO];
    return YES;
}

- (IBAction)textFieldDidChangedText:(id)sender {
    if (_mailAddressTextField.text.length > 0 &&
        _passWordTextField.text.length > 0) {
        [_signInButton setEnabled:YES];
    } else {
        [_signInButton setEnabled:NO];
    }
}

#pragma mark - call api

- (void)pingToSever {
    [[GBRequestManager sharedManager] asyncGET:[NSString stringFromConst:gbURLPingToSever] parameters:nil isShowLoadingView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"extendedInfor" ];
            NSInteger totalGanbareNumber = [result intForKey:@"totalGanbareNumber"];
            self.totalGanbareLabel.text = [NSString stringWithFormat:@"%022ldGB",(long)totalGanbareNumber];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)callAPILogin {
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:_mailAddressTextField.text forKey:@"email"];
    [params setObject:[_passWordTextField.text encyptMD5] forKey:@"password"];
    
//    [params setObject:@"ganbaretest12@gmail.com" forKey:@"email"];
//    [params setObject:[[NSString stringWithFormat:@"123456" ] encyptMD5] forKey:@"password"];
    [params setObject:@"1" forKey:@"loginType"];
    
    [[GBRequestManager sharedManager] asyncPOST:[NSString stringFromConst:gbURLSessions] parameters:params isShowLoadingView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            NSString *token = [data objectForKey:@"token"];
            if (token) {
                [[GBRequestManager sharedManager] setToken:token];
                [kGBUserDefaults setValue:token forKey:kGBAuthTokenKey];
                [kGBUserDefaults synchronize];
            }
            NSString *userID = [data objectForKey:@"userId"];
            if (userID.length > 0) {
                [kGBUserDefaults setObject:userID forKey:kGBUserIDKey];
                [kGBUserDefaults synchronize];
            }
            NSLog(@"token :%@, userid :%@",kGBAuthToken,kGBUserID);
            [self setUserDefaults];
            [self changeRootToMainMenu];
        } else {
            UIAlertView *signinFail = [[UIAlertView alloc] initWithTitle:@"ユーザー名とかパスワードが間違っています" message:nil delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:nil, nil];
            [signinFail show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - set userDefaults
- (void)setUserDefaults{
    [kGBUserDefaults setObject:_mailAddressTextField.text forKey:kGBMailAddressKey];
    [kGBUserDefaults setObject:_passWordTextField.text  forKey:kGBLoginPassWordKey];
    [kGBUserDefaults synchronize];
}
@end
