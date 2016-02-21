//
//  GBUserModel.m
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBUserEntity.h"

@implementation GBUserEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.identifier = [dictionary stringForKey:@"userId"];
        self.userName = [dictionary stringForKey:@"username"];
        self.userMailAddress = [dictionary stringForKey:@"email"];
        self.favoristUser = [dictionary boolForKey:@"isFavoristUser"];
        self.favoriteNumber = [dictionary stringForKey:@"favoriteNumber"];
        self.favoritedNumber = [dictionary stringForKey:@"favoritedNumber"];
        self.receivedGanbareNumber = [dictionary intForKey:@"receivedGanbareNumber"];
        self.sentGanbareNumber = [dictionary intForKey:@"sentGanbareNumber"];
        self.ganbaruNumber = [dictionary stringForKey:@"ganbaruNumber"];
        self.receivedPinNumber = [dictionary stringForKey:@"receivedPinNumber"];
        self.sentPinNumber = [dictionary stringForKey:@"sentPinNumber"];
        self.avatarURL = [dictionary urlForKey:@"avatarUrl"];
        self.backgroundUrl = [dictionary urlForKey:@"backgroundUrl"];
        self.profile = [dictionary stringForKey:@"userProfile"];
        if ([dictionary stringForKey:@"loginId"].length > 0) {
            self.loginId = [NSString stringWithFormat:@"@%@",[dictionary stringForKey:@"loginId"]];
        }
    }
    return self;
}

- (void)addUserToFavorite {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:self.identifier forKey:@"friendId"];
    [[GBRequestManager sharedManager] asyncPOST:[NSString stringWithFormat:@"%@%@/favorites",gbURLUsers,kGBUserID] parameters:params isShowLoadingView:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:self forKey:@"object"];
            
            [userInfo setObject:@[
                                  @{@"value" : [NSNumber numberWithBool:YES], @"key" : @"favoristUser"}] forKey:@"values"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kGBItemWasChangedNotification
                                                                object:self
                                                              userInfo:userInfo];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)removeUserFromFavorite {
    [[GBRequestManager sharedManager] asyncDELETE:[NSString stringWithFormat:@"%@%@/favorites/%@",gbURLUsers,kGBUserID,self.identifier] parameters:nil
                                isShowLoadingView:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                    if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
                                        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:self forKey:@"object"];
                                        
                                        [userInfo setObject:@[
                                                              @{@"value" : [NSNumber numberWithBool:NO], @"key" : @"favoristUser"}] forKey:@"values"];
                                        [[NSNotificationCenter defaultCenter] postNotificationName:kGBItemWasChangedNotification
                                                                                            object:self
                                                                                          userInfo:userInfo];
                                    }
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    
                                }];
}

@end
