//
//  GBEditGanbareViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/16/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBEditGanbareViewController.h"
#import "GBGlobalDatePicker.h"
#import "GBSearchLocationViewController.h"
#import "GBCropImageViewController.h"
#import "GBGanbareSearchTagsViewController.h"
#define spaceToBottom 70

@interface GBEditGanbareViewController ()<GBGlobalDatePickerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,GBCropImageViewControllerDelegate,UITextViewDelegate>
@property (strong, nonatomic) GBGlobalDatePicker *datePicker;
@property (strong, nonatomic) UIImage *sourceImage;

@end

@implementation GBEditGanbareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.mode == GBGanbareEditModeNew) {
        self.doneButton.backgroundColor = [UIColor redColor];
        [self.doneButton setTitle:@"投稿" forState:UIControlStateNormal];
        [self.doneButton setTitle:@"投稿" forState:UIControlStateSelected];
        self.ganbareTextView.placeholder = @"ガンバル入力";
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshView];
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewWillLayoutSubviews {
    _datePicker.width = self.view.width;
    _datePicker.height = self.view.height;
}

#pragma mark - setup

- (void)setGanbareModel:(GBGanbareEntity *)ganbareModel {
    _ganbareModel = ganbareModel;
}

- (void)setMode:(GBGanbareEditMode)mode {
    _mode = mode;
}

- (void)refreshView {
    if (!_ganbareModel) {
        _ganbareModel = [[GBGanbareEntity alloc] init];
    }
    self.ganbareTextView.text = _ganbareModel.ganbaruContent;
    [self refreshTagsView];
    if (_ganbareModel.expiredDate) {
        self.expiringDateLabel.text =[NSString stringWithFormat:@"%@",[ _ganbareModel.expiredDate stringValueFormattedBy:@"yy/MM/dd/HH:mm"]];
    }
    self.ganbareAddressLabel.text = _ganbareModel.ganbaruLocationName;
    if (!self.ganbareImageView.image) {
        if (_ganbareModel.ganbareImageURL) {
            [self.ganbareImageView setImageWithImageURL:_ganbareModel.ganbareImageURL placeholderImage:nil withCache:YES success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                self.ganbareImageView.image = image;
                [self validateAllField];
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                [self validateAllField];
            }];
        }
    }

    [self validateAllField];
}

- (void)validateAllField {
    if ([_ganbareModel.ganbaruContent removeWhitePlace].length == 0 ||
        !_ganbareModel.expiredDate ||
        _ganbareModel.ganbaruLocationName.length == 0 ||
        !_ganbareModel.ganbareLocation ||
        !self.ganbareImageView.image ) {
        self.doneButton.alpha = 0.5;
        self.doneButton.enabled = NO;
    } else {
        self.doneButton.alpha = 1.0;
        self.doneButton.enabled = YES;
    }
}
- (void)refreshTagsView
{
    NSArray *viewsToRemove = [self.tagsView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }

    NSArray *tags = _ganbareModel.ganbaruTags;
    int startIndex = 0, endIndex = 0;
    int width = 0;
    int viewNumber = 0;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:GBGlobalNormalFontName size:14]};
    for (int i = 0; i < tags.count; i++) {
        NSString *tag;
        if (i != tags.count - 1) {
            tag = [NSString stringWithFormat:@"#%@,",tags[i]];
            
        } else {
            tag = [NSString stringWithFormat:@"#%@",tags[i]];
        }
        width += [tag sizeWithAttributes:attributes].width + 10;
        if (width >= self.tagsView.width) {
            endIndex = i  ;
            [self addTagViewWithStartIndex:startIndex endIndex:endIndex originY:(viewNumber * 25.0) + 5];
            startIndex = endIndex ;
            viewNumber ++;
            width = [tag sizeWithAttributes:attributes].width + 10;
        }
        if (i == tags.count - 1) {
            [self addTagViewWithStartIndex:startIndex endIndex:tags.count originY:(viewNumber * 25.0) + 5];
        }
    }
    _tagViewHeightConstraint.constant = (viewNumber + 1) * 25.0 + 5;
    _backgroundTagViewHeightConstraint.constant = _tagViewHeightConstraint.constant ;
    [self heightTableHeaderToFit];
}


- (void)addTagViewWithStartIndex:(int)startIndex endIndex:(NSInteger)endIndex originY:(float)y
{
    UIView *tagSubView = [[UIView alloc] initWithFrame:CGRectMake(0, y , 0, 25)];
    [self.tagsView addSubview:tagSubView];
    NSArray *tags = _ganbareModel.ganbaruTags;
    float width = 0;
    float x = 0;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:GBGlobalNormalFontName size:14]};

    for (int i = startIndex; i < endIndex; i ++) {
        UIButton *tagButton = [UIButton new];;
        tagButton.backgroundColor = [UIColor clearColor];
//        tagButton.layer.masksToBounds = YES;
//        [tagButton addTarget:self action:@selector(tagButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        [tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tagButton.titleLabel.font = [UIFont fontWithName:GBGlobalNormalFontName size:14];
        [tagSubView addSubview:tagButton];
        
        NSString *tag;

        if (i != endIndex - 1) {
            tag = [NSString stringWithFormat:@"#%@,",tags[i]];

        } else {
            tag = [NSString stringWithFormat:@"#%@",tags[i]];
        }
        [tagButton setTitle:tag forState:UIControlStateNormal];

        int buttonWidth = [tag sizeWithAttributes:attributes].width +5;
        width += buttonWidth + 5;
        tagButton.frame = CGRectMake(x, 0, buttonWidth, 20);
        x += buttonWidth + 5;
    }
    tagSubView.width = width;
//    tagSubView.center = CGPointMake(self.tagsView.width / 2, tagSubView.center.y);
}




#pragma mark - call api

- (void)creatNewGanbare {
    NSMutableDictionary *params = [NSMutableDictionary new];

    NSString *locationJsonString = [self jsonStringFromArray:_ganbareModel.ganbareLocation];
    
    if ([_ganbareModel.expiredDate compare:[NSDate date]] == NSOrderedAscending) {
        _ganbareModel.expiredDate = [NSDate date];
    }
    [params setObject:_ganbareModel.ganbaruContent forKey:@"ganbaruContent"];
    [params setObject:[_ganbareModel.expiredDate stringValueFormattedBy:@"yyyyMMddHHmmss"] forKey:@"expiredDate"];
    [params setObject:locationJsonString forKey:@"ganbaruLocation"];
    [params setObject:_ganbareModel.ganbaruLocationName forKey:@"ganbaruLocationName"];
    
    NSString *tagsJsonString;
    if (_ganbareModel.ganbaruTags.count > 0) {
        tagsJsonString = [self jsonStringFromArray:_ganbareModel.ganbaruTags];
        [params setObject:tagsJsonString forKey:@"ganbaruTags"];

    }
    [[GBRequestManager sharedManager] asyncPOSTData :[NSString stringWithFormat:@"%@",gbURLCreatNewGanbaru] parameters:params isShowLoadingView:YES constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
        if (self.ganbareImageView.image) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.ganbareImageView.image, 1.0f) name:@"image" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
        }
    } success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            [self goBack:nil];
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

- (void)callAPIUpdateGanbare {
    
    if ([_ganbareModel.expiredDate compare:[NSDate date]] == NSOrderedAscending) {
        _ganbareModel.expiredDate = [NSDate date];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:_ganbareModel.identifier forKey:@"ganbaruId"];
    [params setObject:_ganbareModel.ganbaruLocationName forKey:@"ganbaruLocationName"];
      [params setObject:_ganbareModel.ganbareLocation forKey:@"ganbaruLocation"];
    [params setObject:[_ganbareModel.expiredDate stringValueFormattedBy:@"yyyyMMddHHmmss"] forKey:@"expiredDate"];
    if (_ganbareModel.ganbaruTags.count > 0) {
        [params setObject:_ganbareModel.ganbaruTags forKey:@"ganbaruTags"];
    }
    
    [[GBRequestManager sharedManager] asyncPUT:[NSString stringWithFormat:@"%@%@",gbURLGanbare,_ganbareModel.identifier] parameters:params isShowLoadingView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:_ganbareModel forKey:@"object"];
            
            [userInfo setObject:@[
                                  @{@"value" : _ganbareModel.ganbaruLocationName, @"key" : @"ganbaruLocationName"},
                                  @{@"value" : _ganbareTextView.text, @"key" : @"ganbaruContent"},
                                  @{@"value" : _ganbareModel.ganbareLocation, @"key" : @"ganbareLocation"},
                                  @{@"value" : _ganbareModel.expiredDate, @"key" : @"expiredDate"},
                                  @{@"value" : _ganbareModel.ganbaruTags, @"key" : @"ganbaruTags"},
                                  @{@"value" : _ganbareModel.ganbareImageURL, @"key" : @"ganbareImageURL"}] forKey:@"values"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kGBItemWasChangedNotification
                                                                object:self
                                                              userInfo:userInfo];

            [self goBack:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)updateGanbareImage {
    [[GBRequestManager sharedManager] asyncPOSTData :[NSString stringWithFormat:@"%@%@/ganbaru/%@/images",gbURLUsers,kGBUserID,_ganbareModel.identifier] parameters:nil isShowLoadingView:YES constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
        if (self.ganbareImageView.image) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.ganbareImageView.image, 1.0f) name:@"image" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
        }
    } success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"data"];
            _ganbareModel.ganbareImageID = [result stringForKey:@"imageId"];
            _ganbareModel.ganbareImageURL = [result urlForKey:@"imageUrl"];
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

#pragma mark - date picker

- (void)showDatePicker {
    if (!self.datePicker) {
        self.datePicker = [[GBGlobalDatePicker alloc] init];
        self.datePicker.delegate = self;
        [self.datePicker.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    }
    [self.datePicker.datePicker setMinimumDate:[NSDate date]];
    if (_ganbareModel.expiredDate) {
        [self.datePicker setDate:_ganbareModel.expiredDate];
    } 
    
    [self.datePicker show];
}

- (void)pickedDatePicker:(GBGlobalDatePicker *)datePicker withDate:(NSDate *)date {
    _ganbareModel.expiredDate = date;
    [self refreshView];
}

#pragma mark - action

- (IBAction)cancelButtonClicked:(id)sender {
    [self goBack:sender];
}

- (IBAction)cameraButtonClicked:(id)sender {
    [self hiddenKeyboard];
    [self takePhoto];
}

- (IBAction)locationButtonClicked:(id)sender{
    [self hiddenKeyboard];
    
}
- (IBAction)calendarButtonClicked:(id)sender{
    [self hiddenKeyboard];
    [self showDatePicker];
}
- (IBAction)tagButtonClicked:(id)sender{
    [self hiddenKeyboard];
    [self performSegueWithIdentifier:@"showTagViewSegue" sender:self];
}

- (IBAction)doneButtonClicked:(id)sender {
    [self hiddenKeyboard];
    if (self.mode == GBGanbareEditModeEdit) {
        [self updateGanbareImage];
        [self callAPIUpdateGanbare];
    } else {
        [self creatNewGanbare];
    }
}

- (void)takePhoto
{
    UIActionSheet *imageActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"キャンセル", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"カメラで撮影", nil), NSLocalizedString(@"アルバムから選択", nil),  nil];
    [imageActionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSearchLocationSegue"]) {
        GBSearchLocationViewController *searchLocationViewController = (GBSearchLocationViewController *)segue.destinationViewController;
        searchLocationViewController.ganbare = _ganbareModel;
        
    }
    if ([segue.identifier isEqualToString:@"showCropImageViewSegue"]) {
        GBCropImageViewController *cropImageViewController = (GBCropImageViewController *)segue.destinationViewController;
        cropImageViewController.delegate = self;
        [cropImageViewController setSourceImage:_sourceImage];

        [cropImageViewController setCropImageType:GBCropImageTypeRectangle];
    }
    if ([segue.identifier isEqualToString:@"showTagViewSegue"]) {
        GBGanbareSearchTagsViewController *searchTagViewController = (GBGanbareSearchTagsViewController *)segue.destinationViewController;
        searchTagViewController.ganbare = _ganbareModel;
    }
}

#pragma mark - text view delegate 
- (void)textViewDidChange:(UITextView *)textView {
    _ganbareModel.ganbaruContent = textView.text;
    [self refreshView];
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
    _sourceImage = pickedImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"showCropImageViewSegue" sender:self];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - crop image
- (void)croppedImage:(UIImage *)image imageId:(NSString *)imageId {
    self.ganbareImageView.image = image;
    [self refreshView];
}

- (NSString *)jsonStringFromArray:(NSArray *)array {
    NSError *errorDictionary;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&errorDictionary];
    if (!jsonData) {
        NSLog(@"Got an error: %@", errorDictionary);
        return nil;
    }
    else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
   
}

- (void)heightTableHeaderToFit {

    UIView *header = self.ganbareHeaderView;
    
    [header setNeedsLayout];
    [header layoutIfNeeded];
    
    CGFloat height = self.ganbareImageView.bottomYPoint + spaceToBottom;
    CGRect frame = header.frame;
    
    frame.size.height = height;
    header.frame = frame;
    
    self.ganbareTableView.tableHeaderView = header;
    
}

@end
