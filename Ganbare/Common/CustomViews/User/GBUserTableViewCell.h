//
//  GBUserTableViewCell.h
//  Ganbare
//
//  Created by Phung Long on 9/11/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBUserEntity.h"

@interface GBUserTableViewCell : UITableViewCell

@property (strong, nonatomic) GBUserEntity *userModel;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatar;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userProfileLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginIDLabel;

@end
