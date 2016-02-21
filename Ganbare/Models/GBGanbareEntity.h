//
//  GBGanbareEntity.h
//  Ganbare
//
//  Created by Phung Long on 9/7/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GBItem.h"
#import "GBUserEntity.h"

@interface GBGanbareEntity : GBItem

@property (strong, nonatomic) GBUserEntity *user;
@property (strong, nonatomic) NSString *ganbaruContent;
@property (strong, nonatomic) NSString *ganbaruTitle;
@property (strong, nonatomic) NSMutableArray *ganbaruTags;
@property (assign, nonatomic) NSInteger ganbareNumber;
@property (assign, nonatomic) NSInteger ganbareUserNumber;
@property (assign, nonatomic) NSInteger pinningUserNumber;
@property (assign, nonatomic) BOOL pinning;
@property (strong, nonatomic) NSDate *expiredDate;
@property (strong, nonatomic) NSDate *createDate;
@property (strong, nonatomic) NSArray *ganbareLocation;
@property (strong, nonatomic) NSArray *userGanbereds;
@property (strong, nonatomic) NSString *ganbaruLocationName;
@property (strong, nonatomic) NSURL *ganbareImageURL;
@property (strong, nonatomic) NSString *ganbareImageID;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)pinGanbare ;
- (void)unpinGanbare;
- (void)ganbareAction;
@end
