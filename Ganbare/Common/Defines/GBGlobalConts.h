//
//  QKGlobalConts.h
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBGlobalConts : NSObject

// font
extern NSString *const GBGlobalNormalFontName ;


//Sort Type

extern NSString const *SORT_TYPE_HOT;
extern NSString const *SORT_TYPE_NEW;
extern NSString const *SORT_TYPE_EXPIRING;
extern NSString const *SORT_TYPE_TAG;

+ (NSDictionary *)SORT_TYPE_MAP;

extern NSString const *FILTER_TYPE_HOT;
extern NSString const *SFILTER_TYPE_NEW;
extern NSString const *FILTER_TYPE_EXPIRING;
extern NSString const *FILTER_TYPE_TAG;


+ (NSDictionary *)FILTER_TYPE_VISITOR_MAP;

extern NSString const *FILTER_TYPE_USER_FAVORITE;
extern NSString const *FILTER_TYPE_USER_PIN;
extern NSString const *FILTER_TYPE_USER_HOT;
extern NSString const *FILTER_TYPE_USER_NEW;
extern NSString const *FILTER_TYPE_USER_EXPIRING;
extern NSString const *FILTER_TYPE_USER_TAG;

+ (NSDictionary *)FILTER_TYPE_USER_MAP;

@end
