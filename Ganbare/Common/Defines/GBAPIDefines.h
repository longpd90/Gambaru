//
//  QKAPIDefines.h
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <Foundation/Foundation.h>
#define GB_CODE_SUCCESS 0
#define GB_CODE_INVALID_TOKEN 3

#define BASE_URL @"http://133.242.53.250:8888/v1/"
#define BASE_URL_V2 @"http://133.242.53.250:8888/v2/"

@interface GBAPIDefines : NSObject

extern NSString const *gbURLPingToSever;
extern NSString const *gbURLGanbare;
extern NSString const *gbURLUsers;
extern NSString const *gbURLSessions ;
extern NSString const *gbURLAvatars ;
extern NSString const *gbURLBackgrounds ;
extern NSString const *gbURLSearchTags ;
extern NSString const *gbURLValidators ;

// version 2
extern NSString const *gbURLRegistUsers ;
extern NSString const *gbURLCreatNewGanbaru;

// status code
extern NSString const *STATUS_CODE;
extern NSNumber const *CODE_SUCCESS;
@end
