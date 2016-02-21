//
//  GBConfirmAccountViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/8/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBConfirmAccountViewController.h"

@interface GBConfirmAccountViewController ()

@end

@implementation GBConfirmAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginIDLabel.text = kGBLoginID;
    self.userNameLabel.text = kGBUserName;
    self.mailAddressLabel.text = kGBMailAddress;
    if (_userEntity.avatarImage) {
        self.avatarImageView.image = _userEntity.avatarImage;
    }
    if (_userEntity.coverImage) {
        self.coverImageView.image = _userEntity.coverImage;
    }
    [_ganbareToolbarView setSignupInterface];
    
    // Do any additional setup after loading the view.
}

#pragma mark - action

- (void)setUserEntity:(GBUserEntity *)userEntity {
    _userEntity = userEntity;
}

- (IBAction)confirmButtonClicked:(id)sender {
    [self callApiRegistAccount];
}

- (IBAction)gobackButtonClicked:(id)sender {
    [self goBack:sender];
}


#pragma mark - call api

- (void)callApiRegistAccount {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:kGBMailAddress forKey:@"email"];
    [params setObject:kGBUserName forKey:@"username"];
    [params setObject:@"1" forKey:@"loginType"];
    [params setObject:kGBLoginID forKey:@"loginId"];
    [params setObject:kGBLoginPassWord forKey:@"password"];
    [params setObject:[kGBLoginPassWord encyptMD5] forKey:@"encryptedPassword"];
    
    [[GBRequestManager sharedManager] asyncPOSTData :[NSString stringFromConst:gbURLRegistUsers]
                                          parameters:params
                                   isShowLoadingView:YES
                           constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
        if (self.userEntity.avatarImage) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.userEntity.avatarImage, 1.0f) name:@"avatar" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
        }
        if (self.userEntity.coverImage) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.userEntity.coverImage, 1.0f) name:@"background" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
        }
    } success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            [self setUserIDDefaulf:[responseObject objectForKey:@"data"]];
            [self performSegueWithIdentifier:@"showConfirmFaileSegue" sender:self];
            NSLog(@"response :%@",responseObject);
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)setUserIDDefaulf:(NSDictionary *)dictionary {
    [kGBUserDefaults setObject:[dictionary objectForKey:@"userId"] forKey:kGBUserIDKey];
}



@end
