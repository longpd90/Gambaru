//
//  GBUserTableViewCell.m
//  Ganbare
//
//  Created by Phung Long on 9/11/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBUserTableViewCell.h"
#import "UIImageView+AFNetworking.h"


@implementation GBUserTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setUserModel:(GBUserEntity *)userModel {
    _userModel = userModel;
    [self.userAvatar setImageWithURL:_userModel.avatarURL];
    self.userNameLabel.text = _userModel.userName;
    self.userProfileLabel.text =_userModel.profile;
    self.loginIDLabel.text = _userModel.loginId;
}

@end
