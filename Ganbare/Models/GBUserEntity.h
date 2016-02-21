//
//  GBUserModel.h
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBItem.h"

@interface GBUserEntity : GBItem

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userMailAddress;
@property (assign, nonatomic) NSString * favoriteNumber;
@property (assign, nonatomic) NSString * favoritedNumber;
@property (assign, nonatomic) NSInteger receivedGanbareNumber;
@property (assign, nonatomic) NSInteger sentGanbareNumber;
@property (assign, nonatomic) NSString * ganbaruNumber;
@property (assign, nonatomic) NSString * receivedPinNumber;
@property (assign, nonatomic) NSString * sentPinNumber;
@property (strong, nonatomic) NSURL *avatarURL;
@property (strong, nonatomic) NSURL *backgroundUrl;
@property (strong, nonatomic) NSString *profile;
@property (strong, nonatomic) UIImage *avatarImage;
@property (strong, nonatomic) UIImage *coverImage;
@property (strong, nonatomic) NSString *avatarId;
@property (strong, nonatomic) NSString *backgroundId;
@property (strong, nonatomic) NSString *loginId;

@property (assign, nonatomic) BOOL favoristUser;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)removeUserFromFavorite;
- (void)addUserToFavorite ;

@end
