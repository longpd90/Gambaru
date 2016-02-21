
//
//  GBGanbareEntity.m
//  Ganbare
//
//  Created by Phung Long on 9/7/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGanbareEntity.h"

@implementation GBGanbareEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.user = [[GBUserEntity alloc] initWithDictionary:[dictionary objectForKey:@"user"]];
        NSDictionary *ganbareDictionarty = [dictionary objectForKey:@"ganbaru"];
        self.identifier = [ganbareDictionarty stringForKey:@"ganbaruId"];
        self.ganbaruContent = [ganbareDictionarty stringForKey:@"ganbaruContent"];
        self.ganbaruTags = [ganbareDictionarty objectForKey:@"ganbaruTags"];
        self.ganbaruLocationName = [ganbareDictionarty stringForKey:@"ganbaruLocationName"];
        self.ganbareNumber = [ganbareDictionarty intForKey:@"ganbareNumber"];
        self.ganbareImageURL = [ganbareDictionarty urlForKey:@"ganbaruImageUrl"];
        self.ganbareUserNumber = [ganbareDictionarty intForKey:@"ganbareUserNumber"];
        self.pinningUserNumber = [ganbareDictionarty intForKey:@"pinningUserNumber"];
        self.pinning = [ganbareDictionarty boolForKey:@"isPinning"];
        self.expiredDate = [ganbareDictionarty dateForKey:@"expiredDate" format:@"yyyyMMddHHmmss"];
        self.createDate = [ganbareDictionarty dateForKey:@"createDate" format:@"yyyyMMddHHmmss"];
        self.ganbareLocation = [ganbareDictionarty objectForKey:@"ganbaruLocation"];
        self.userGanbereds = ganbareDictionarty[@"listGanbare"];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.user = [[GBUserEntity alloc] init];
    }
    return self;
}

#pragma mark - call api

- (void)pinGanbare {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:self.identifier forKey:@"ganbaruId"];
    
    [[GBRequestManager sharedManager] asyncPOST:[NSString stringWithFormat:@"%@%@/pins",gbURLUsers,kGBUserID] parameters:params isShowLoadingView:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:self forKey:@"object"];
            
            [userInfo setObject:@[
                                  @{@"value" : [NSNumber numberWithBool:YES], @"key" : @"pinning"}] forKey:@"values"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kGBItemWasChangedNotification
                                                                object:self
                                                              userInfo:userInfo];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)unpinGanbare {
    [[GBRequestManager sharedManager] asyncDELETE:[NSString stringWithFormat:@"%@%@/pins/%@",gbURLUsers,kGBUserID,self.identifier] parameters:nil isShowLoadingView:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:self forKey:@"object"];
            
            [userInfo setObject:@[
                                  @{@"value" : [NSNumber numberWithBool:NO], @"key" : @"pinning"}] forKey:@"values"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kGBItemWasChangedNotification
                                                                object:self
                                                              userInfo:userInfo];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)ganbareAction {
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:self.identifier forKey:@"ganbaruId"];
    [params setObject:@"1" forKey:@"ganbareNumber"];
    
    [[GBRequestManager sharedManager] asyncPUT:[NSString stringWithFormat:@"%@%@/ganbare",gbURLUsers,kGBUserID] parameters:params isShowLoadingView:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:self forKey:@"object"];
            
            [userInfo setObject:@[
                                  @{@"value" : [NSNumber numberWithInteger:(self.ganbareNumber + 1)], @"key" : @"ganbareNumber"}] forKey:@"values"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kGBWasAddedGanbareNotification
                                                                object:self
                                                              userInfo:userInfo];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
