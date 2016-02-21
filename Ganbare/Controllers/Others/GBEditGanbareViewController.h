//
//  GBEditGanbareViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/16/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseViewController.h"
#import "GBGanbareEntity.h"
#import "GBWebImage.h"

@interface GBEditGanbareViewController : GBBaseViewController
@property (nonatomic) GBGanbareEditMode mode;
@property (strong, nonatomic) GBGanbareEntity *ganbareModel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UITextView *ganbareTextView;
@property (weak, nonatomic) IBOutlet UILabel *expiringDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *ganbareAddressLabel;
@property (weak, nonatomic) IBOutlet GBWebImage *ganbareImageView;
@property (weak, nonatomic) IBOutlet UIView *tagsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundTagViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationLabelHeightConstrait;
@property (weak, nonatomic) IBOutlet UIView *ganbareHeaderView;

@property (weak, nonatomic) IBOutlet UITableView *ganbareTableView;

- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)locationButtonClicked:(id)sender;
- (IBAction)calendarButtonClicked:(id)sender;
- (IBAction)tagButtonClicked:(id)sender;
- (IBAction)doneButtonClicked:(id)sender;
- (IBAction)cameraButtonClicked:(id)sender ;
@end
