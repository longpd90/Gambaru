//
//  GBSignupViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBSignupViewController.h"
#import "GBUserEntity.h"
#import "GBCropImageViewController.h"
#import "GBConfirmAccountViewController.h"
#import "AFURLSessionManager.h"

#define spaceToBottom 70

@interface GBSignupViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,GBCropImageViewControllerDelegate,UITextFieldDelegate>
@property (nonatomic, strong)GBUserEntity *userEntity;
@property (assign, nonatomic) GBCropImageType cropImageType;
@property (strong, nonatomic) UIImage *sourceImage;
@end

@implementation GBSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_signupButton setEnabled:NO];
    [self.gabareToolBarView setSignupInterface];
    if (!_userEntity) {
        _userEntity = [GBUserEntity new];
    }
}

#pragma mark - action

- (IBAction)confirmButtonClicked:(id)sender {
    [self setUserDefaults];
    [self performSegueWithIdentifier:@"showConfirmAccountSegue" sender:self];
}

- (IBAction)updateAvatar:(id)sender {
    _cropImageType = GBCropImageTypeSquare;
    [self takePhoto];
}

- (IBAction)updateCoverPhoto:(id)sender {
    _cropImageType = GBCropImageTypeRectangle;
    [self takePhoto];
}

- (IBAction)deleteAvatar:(id)sender {
    self.avatarButtonHeightConstraint.constant = 30;
    self.avatarWidthConstraint.constant = 130;
    [self.avatarButton setBackgroundImage:[UIImage imageNamed:@"take-photo-background"] forState:UIControlStateNormal];
    [self.avatarButton setTitle:@"画像を選択" forState:UIControlStateNormal];
    [self.avatarButton setTitle:@"画像を選択" forState:UIControlStateSelected];
    self.userEntity.avatarImage = nil;
    [self heightTableHeaderToFit];

}

- (IBAction)deleteBackground:(id)sender {
    
    self.backgroundButtonHeightConstraint.constant = 30;
    self.backgroundButtonWidthConstraint.constant = 130;
    [self.backgroundButton setBackgroundImage:[UIImage imageNamed:@"take-photo-background"] forState:UIControlStateNormal];
    [self.backgroundButton setTitle:@"画像を選択" forState:UIControlStateNormal];
    [self.backgroundButton setTitle:@"画像を選択" forState:UIControlStateSelected];
    self.userEntity.coverImage = nil;
    [self heightTableHeaderToFit];

}

- (void)takePhoto
{
    UIActionSheet *imageActionSheet;
    if ((_cropImageType == GBCropImageTypeSquare && self.userEntity.avatarImage )||
        ( _cropImageType == GBCropImageTypeRectangle && self.userEntity.coverImage) ){
        imageActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"キャンセル", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"カメラで撮影", nil), NSLocalizedString(@"アルバムから選択", nil), NSLocalizedString(@"削除", nil),  nil];
    } else {
        
        imageActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"キャンセル", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"カメラで撮影", nil), NSLocalizedString(@"アルバムから選択", nil),  nil];
    }
    
    [imageActionSheet showInView:[UIApplication sharedApplication].keyWindow];
    [self.view endEditing:YES];
}

#pragma mark - call api

- (void)callAPIValidate {
    NSMutableDictionary *params = [NSMutableDictionary new];
    if (_validateMode == GBValidateModeLoginID) {
        [params setObject:@"1" forKey:@"validatorType"];
        [params setObject:_loginIDTextField.text forKey:@"loginId"];
    } else {
        [params setObject:@"2" forKey:@"validatorType"];
        [params setObject:_mailAddressTextField.text forKey:@"email"];
    }
    [[GBRequestManager sharedManager] asyncGET:[NSString stringWithFormat:@"%@",gbURLValidators] parameters:params isShowLoadingView:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            
            if (_validateMode == GBValidateModeLoginID) {
                self.loginIDCheckImageView.hidden = NO;
            } else {
                self.mailCheckImageView.hidden = NO;
            }
        } else {
            if (_validateMode == GBValidateModeLoginID) {
                self.loginIDCheckImageView.hidden = YES;
            } else {
                self.mailCheckImageView.hidden = YES;
            }
        }
        [self validateAllField];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error  %@",error);
        
    }];
}

#pragma mark - set userDefaults
- (void)setUserDefaults{
    [kGBUserDefaults setObject:_loginIDTextField.text forKey:kGBLoginIDKey];
    [kGBUserDefaults setObject:_userNameTextField.text forKey:kGBUserNameKey];
    [kGBUserDefaults setObject:_mailAddressTextField.text forKey:kGBMailAddressKey];
    [kGBUserDefaults setObject:_passwordTextField.text  forKey:kGBLoginPassWordKey];
    [kGBUserDefaults synchronize];
}

#pragma mark - text field delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {

}

- (BOOL) textFieldShouldClear:(UITextField *)textField{
    if (textField == _loginIDTextField) {
        _validateMode = GBValidateModeLoginID;
        self.loginIDCheckImageView.hidden = YES;
    }
    
    if (textField == _mailAddressTextField) {
        _validateMode = GBValidateModeEmail;
        self.mailCheckImageView.hidden = YES;
    }
    if (textField == _passwordTextField) {
        _passwordCheckImageView.hidden = YES;
    }
    if (textField == _userNameTextField) {
        _useNameCheckImageView.hidden = YES;
    }
    [self validateAllField];
    return YES;
}

- (IBAction)textFieldDidChange:(UITextField *)textField {
    if (textField == _loginIDTextField) {
        _validateMode = GBValidateModeLoginID;
        if (textField.text.length >= 3) {
            [self callAPIValidate];
        } else {
            self.loginIDCheckImageView.hidden = YES;
            [self validateAllField];
        }
    }
    
    if (textField == _mailAddressTextField) {
        _validateMode = GBValidateModeEmail;
        if (textField.text.length >= 6) {
            [self callAPIValidate];
        } else {
            self.mailCheckImageView.hidden = YES;
            [self validateAllField];

        }
    }
    if (textField == _passwordTextField) {
        if (textField.text.length >= 6 && textField.text.length <= 30) {
            _passwordCheckImageView.hidden = NO;
        } else {
            _passwordCheckImageView.hidden = YES;
        }
        [self validateAllField];
    }
    if (textField == _userNameTextField) {
        if (textField.text.length > 0) {
            _useNameCheckImageView.hidden = NO;
        } else {
            _useNameCheckImageView.hidden = YES;
        }
        [self validateAllField];
    }
}

- (void)validateAllField {
    if (_loginIDCheckImageView.hidden == YES||
        _useNameCheckImageView.hidden == YES ||
        _passwordCheckImageView.hidden == YES ||
        _mailCheckImageView.hidden == YES) {
        [_signupButton setEnabled:NO];
    } else {
        [_signupButton setEnabled:YES];
    }
}

#pragma mark -  ActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == GBTakePhotoModeCamera) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:NO completion:nil];
        }
        else
        {
            UIAlertView *altnot=[[UIAlertView alloc]initWithTitle:@"Camera Not Available" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [altnot show];
        }
        
    } else if (buttonIndex == GBTakePhotoModeLibrary) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:NO completion:nil];

    } else if (buttonIndex == GBTakePhotoModeDelete) {
        if (_cropImageType == GBCropImageTypeSquare && self.userEntity.avatarImage ) {
            [self deleteAvatar:nil];
        }
        if ( _cropImageType == GBCropImageTypeRectangle && self.userEntity.coverImage ) {
            [self deleteBackground:nil];
        }

    }

}

#pragma mark - imagepickerview delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    _sourceImage = pickedImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"showCropImageViewSegue" sender:self];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showCropImageViewSegue"]) {
        GBCropImageViewController *cropImageViewController = (GBCropImageViewController *)segue.destinationViewController;
        cropImageViewController.delegate = self;
        [cropImageViewController setSourceImage:_sourceImage];
        [cropImageViewController setCropImageType:_cropImageType];
    } else if ([segue.identifier isEqualToString:@"showConfirmAccountSegue"]) {
        GBConfirmAccountViewController *confirmAccountViewController = (GBConfirmAccountViewController *)segue.destinationViewController;
        confirmAccountViewController.userEntity = _userEntity;
    }
}

#pragma mark - crop image

- (void)croppedImage:(UIImage *)image imageId:(NSString *)imageId {
    if (_cropImageType == GBCropImageTypeRectangle) {
        _userEntity.coverImage = image;
        self.backgroundButtonHeightConstraint.constant = 105;
        self.backgroundButtonWidthConstraint.constant = 280;
        [self.backgroundButton setBackgroundImage:image forState:UIControlStateNormal];
        [self.backgroundButton setTitle:nil forState:UIControlStateNormal];
    } else {
        _userEntity.avatarImage = image;
        self.avatarButtonHeightConstraint.constant = self.avatarWidthConstraint.constant = 66;
        [self.avatarButton setBackgroundImage:image forState:UIControlStateNormal];
        [self.avatarButton setTitle:nil forState:UIControlStateNormal];
    }
    [self heightTableHeaderToFit];
}


- (void)heightTableHeaderToFit {
    UIView *header = self.signupTableView.tableHeaderView;
    
    [header setNeedsLayout];
    [header layoutIfNeeded];
    
    CGFloat height = self.backgroundButton.bottomYPoint + spaceToBottom;
    self.signupHeaderView.height = height;
    self.signupTableView.tableHeaderView = self.signupHeaderView;
    
}

@end
