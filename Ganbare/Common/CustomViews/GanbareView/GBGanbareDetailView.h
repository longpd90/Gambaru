//
//  GBGanbareDetailViiew.h
//  Ganbare
//
//  Created by Phung Long on 9/15/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBGlobalBorderView.h"
#import "GBGanbareEntity.h"
#import "GBWebImage.h"
#import "GBGanbareContentTextView.h"

@class GBGanbareDetailView;
@protocol GBGanbareDetailViewDelegate <NSObject>

@optional
- (void)editGanbare:(GBGanbareEntity *)ganbare;

@end
@interface GBGanbareDetailView : UIView
@property (assign, nonatomic) id<GBGanbareDetailViewDelegate> delegate;
@property (strong, nonatomic)GBGanbareEntity *ganbareModel;
@property (strong, nonatomic)NSString *ganbareID;

@property (weak, nonatomic) IBOutlet GBGlobalBorderView *ganbareView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UILabel *creatDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiringDateLabel;
@property (weak, nonatomic) IBOutlet GBDynamicLabel *gabareNumberLabel;
@property (weak, nonatomic) IBOutlet GBWebImage *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *editGanbareButton;
@property (weak, nonatomic) IBOutlet UIButton *pinGanbareButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *extraButton;
@property (weak, nonatomic) IBOutlet UILabel *loginIDLabel;
@property (weak, nonatomic) IBOutlet GBGanbareContentTextView *ganbareContentTextView;
@property (weak, nonatomic) IBOutlet UIView *backgroundGanbareContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *ganbareButton;

@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet GBWebImage *ganbareImageView;
- (IBAction)ganbareButtonClicked:(id)sender;
- (IBAction)editButtonClicked:(id)sender;
- (IBAction)extraButtonClicked:(id)sender;
- (IBAction)likeButtonClicked:(id)sender;
- (IBAction)pinButtonClicked:(id)sender;
- (IBAction)hiddenComment:(id)sender;
- (void)show;
@end
