//
//  QKAPIDefines.m
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBAPIDefines.h"
@implementation GBAPIDefines

#pragma mark - Master

// api
NSString const *gbURLPingToSever = BASE_URL "systems/";
NSString const *gbURLGanbare = BASE_URL "ganbaru/";
NSString const *gbURLUsers = BASE_URL "users/";
NSString const *gbURLSessions = BASE_URL "sessions/";
NSString const *gbURLAvatars = BASE_URL "avatars/";
NSString const *gbURLBackgrounds = BASE_URL "backgrounds/";
NSString const *gbURLSearchTags = BASE_URL "tags";
NSString const *gbURLValidators = BASE_URL "validators";

// version 2
NSString const *gbURLRegistUsers = BASE_URL_V2 "users/";
NSString const *gbURLCreatNewGanbaru = BASE_URL_V2 "ganbaru/";

// status code
NSString const *STATUS_CODE = @"code";
NSNumber const *CODE_SUCCESS = 0;

@end
