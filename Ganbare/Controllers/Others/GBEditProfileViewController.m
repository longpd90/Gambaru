//
//  GBEditProfileViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/16/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBEditProfileViewController.h"
#import "GBCropImageViewController.h"

@interface GBEditProfileViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,GBCropImageViewControllerDelegate,UITextViewDelegate>
@property (assign, nonatomic) GBCropImageType cropImageType;

@end

@implementation GBEditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ganbareTotalStatusView setOurMissionRedStyle];
    if (!_userEntity) {
        _userEntity = [GBUserEntity new];
    }
    [self setupInterface];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUserEntity:(GBUserEntity *)userEntity {
    _userEntity = userEntity;
}

- (void)setupInterface {
    [self.userAvatarImageView setImageWithQKURL:_userEntity.avatarURL placeholderImage:nil withCache:YES];
    [self.backgroundAvatarImageView setImageWithQKURL:_userEntity.backgroundUrl placeholderImage:nil withCache:YES];
    self.userNameTextView.text = _userEntity.userName;
    self.profileTextView.text = _userEntity.profile;
}

#pragma mark - call API

- (void)updateUserInfo {
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:_userNameTextView.text forKey:@"username"];
    [params setObject:_profileTextView.text forKey:@"profile"];
//    [params setObject:_userEntity.avatarId forKey:@"avatarId"];
//    [params setObject:_userEntity.backgroundId forKey:@"backgroundId"];
    
    [[GBRequestManager sharedManager] asyncPUT:[NSString stringWithFormat:@"%@%@",gbURLUsers,kGBUserID] parameters:params isShowLoadingView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:_userEntity forKey:@"object"];

            [userInfo setObject:@[
                                  @{@"value" : _userNameTextView.text, @"key" : @"userName"},
                                  @{@"value" : _profileTextView.text, @"key" : @"profile"},
                                  @{@"value" : _userEntity.avatarURL, @"key" : @"avatarURL"},
                                  @{@"value" : _userEntity.backgroundUrl, @"key" : @"backgroundUrl"}] forKey:@"values"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kGBItemWasChangedNotification
                                                                object:self
                                                              userInfo:userInfo];

            [self goBack:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    
}

- (void)updateUserAvatarImage {
    [[GBRequestManager sharedManager] asyncPOSTData :[NSString stringWithFormat:@"%@%@/avatars",gbURLUsers,kGBUserID]
                                          parameters:nil
                                   isShowLoadingView:YES
                           constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
        if (self.userAvatarImageView.image) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.userAvatarImageView.image, 1.0f) name:@"image" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
        }
    } success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"data"];
            _userEntity.avatarId = [result stringForKey:@"imageId"];
            _userEntity.avatarURL = [result urlForKey:@"imageUrl"];
            NSLog(@"upload avatar success...");
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Upload photo error...");
    }];
}

- (void)updateUserBackgroundImage {
    [[GBRequestManager sharedManager] asyncPOSTData :[NSString stringWithFormat:@"%@%@/backgrounds",gbURLUsers,kGBUserID]
                                          parameters:nil
                                   isShowLoadingView:YES
                           constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
        if (self.backgroundAvatarImageView.image) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.backgroundAvatarImageView.image, 1.0f) name:@"image" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
        }
    } success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"data"];
            _userEntity.backgroundId = [result stringForKey:@"imageId"];
            _userEntity.backgroundUrl = [result urlForKey:@"imageUrl"];
            NSLog(@"upload backgroud success...");
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Upload photo error...");
    }];
}

#pragma mark - action

- (IBAction)saveButtonClicked:(id)sender {
    if (self.userAvatarImageView.image) {
        [self updateUserAvatarImage];
    }
    if (self.backgroundAvatarImageView.image) {
        [self updateUserBackgroundImage];
    }
    [self hiddenKeyboard];
    [self updateUserInfo];
}

- (IBAction)editAvatarButtonClicked:(id)sender {
    _cropImageType = GBCropImageTypeSquare;
    [self hiddenKeyboard];
    [self takePhoto];
}

- (IBAction)editBackgroundButtonClicked:(id)sender {
    _cropImageType = GBCropImageTypeRectangle;
    [self hiddenKeyboard];
    [self takePhoto];
}

- (IBAction)editNameButtonClicked:(id)sender {
    self.userNameTextView.editable = YES;
    self.userNameEditButton.hidden = YES;
    [self.userNameTextView becomeFirstResponder];
}

- (IBAction)editProfileButtonClicked:(id)sender {
    self.profileTextView.editable = YES;
    self.profileEditButton.hidden = YES;
    [self.profileTextView becomeFirstResponder];
}

- (IBAction)editSNSButtonClicked:(id)sender {
}

- (void)takePhoto
{
    UIActionSheet *imageActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"キャンセル", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"カメラで撮影", nil), NSLocalizedString(@"アルバムから選択", nil),  nil];
    [imageActionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark - text view deleage

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView == _userNameTextView) {
        self.userNameTextView.editable = NO;
        self.userNameEditButton.hidden = NO;
    }

    if (textView == _profileTextView) {
        self.profileTextView.editable = NO;
        self.profileEditButton.hidden = NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([_userNameTextView.text removeWhitePlace].length == 0 ||
        [_profileTextView.text removeWhitePlace].length == 0) {
        self.finishButton.enabled = NO;
        self.finishButton.alpha = 0.5;
    } else {
        self.finishButton.enabled = YES;
        self.finishButton.alpha = 1.0;
    }

}
#pragma mark -  ActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case GBTakePhotoModeCamera:
        {
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
            
            break;
        }
        case GBTakePhotoModeLibrary:
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:NO completion:nil];
        }
    }
}


#pragma mark - imagepickerview delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (_cropImageType == GBCropImageTypeRectangle) {
        _userEntity.coverImage = pickedImage ;
    } else {
        _userEntity.avatarImage = pickedImage ;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"showCropImageViewSegue" sender:self.navigationController];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showCropImageViewSegue"]) {
        GBCropImageViewController *cropImageViewController = (GBCropImageViewController *)segue.destinationViewController;
        cropImageViewController.delegate = self;
        if (_cropImageType == GBCropImageTypeRectangle) {
            [cropImageViewController setSourceImage:_userEntity.coverImage];
        } else {
            [cropImageViewController setSourceImage:_userEntity.avatarImage];
        }
        [cropImageViewController setCropImageType:_cropImageType];
    }
}

#pragma mark - crop image

- (void)croppedImage:(UIImage *)image imageId:(NSString *)imageId {
    if (_cropImageType == GBCropImageTypeRectangle) {
        _userEntity.coverImage = image;
        self.backgroundAvatarImageView.image = image;
    } else {
        _userEntity.avatarImage = image;
        self.userAvatarImageView.image = image;
    }
}

- (void)deleteImage {
    if (_cropImageType == GBCropImageTypeRectangle) {
        _userEntity.coverImage = nil;
    } else {
        _userEntity.avatarImage = nil;
    }
}

@end
