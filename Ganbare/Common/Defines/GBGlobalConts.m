//
//  QKGlobalConts.m
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGlobalConts.h"

@implementation GBGlobalConts

// font
NSString *const GBGlobalNormalFontName = @"HelveticaNeue-Light";

//SORT TYPE
NSString const *SORT_TYPE_HOT = @"1";
NSString const *SORT_TYPE_NEW = @"2";
NSString const *SORT_TYPE_EXPIRING = @"3";
NSString const *SORT_TYPE_TAG = @"4";


+ (NSDictionary *)SORT_TYPE_MAP {
    static NSDictionary *sortType;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sortType = @{
                       SORT_TYPE_HOT : NSLocalizedString(@"NEW", nil),
                       SORT_TYPE_NEW : NSLocalizedString(@"多い", nil),
                       SORT_TYPE_EXPIRING : NSLocalizedString(@"少ない", nil),
                       SORT_TYPE_TAG : NSLocalizedString(@"期限近い", nil),
                       };
        
    });
    return sortType;
}

NSString const *FILTER_TYPE_HOT = @"1";
NSString const *FILTER_TYPE_NEW = @"2";
NSString const *FILTER_TYPE_EXPIRING = @"3";
NSString const *FILTER_TYPE_TAG = @"4";  


+ (NSDictionary *)FILTER_TYPE_VISITOR_MAP {
    static NSDictionary *filterType;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        filterType = @{
                     FILTER_TYPE_HOT : NSLocalizedString(@"HOT", nil),
                     FILTER_TYPE_NEW : NSLocalizedString(@"NEW", nil),
                     FILTER_TYPE_EXPIRING : NSLocalizedString(@"期限間近", nil),
                     FILTER_TYPE_TAG : NSLocalizedString(@"タグクラウド", nil),
                     };
    });
    return filterType;
}

NSString const *FILTER_TYPE_USER_FAVORITE = @"1";
NSString const *FILTER_TYPE_USER_PIN = @"2";
NSString const *FILTER_TYPE_USER_HOT = @"3";
NSString const *FILTER_TYPE_USER_NEW = @"4";
NSString const *FILTER_TYPE_USER_EXPIRING = @"5";
NSString const *FILTER_TYPE_USER_TAG = @"6";

+ (NSDictionary *)FILTER_TYPE_USER_MAP {
    static NSDictionary *filterType;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        filterType = @{
                       FILTER_TYPE_USER_FAVORITE : NSLocalizedString(@"お気に入り", nil),
                       FILTER_TYPE_USER_PIN : NSLocalizedString(@"ピン止め", nil),
                       FILTER_TYPE_USER_HOT : NSLocalizedString(@"HOT", nil),
                       FILTER_TYPE_USER_NEW : NSLocalizedString(@"NEW", nil),
                       FILTER_TYPE_USER_EXPIRING : NSLocalizedString(@"期限間近", nil),
                       FILTER_TYPE_USER_TAG : NSLocalizedString(@"タグクラウド", nil),
                       };
    });
    return filterType;
}

@end
