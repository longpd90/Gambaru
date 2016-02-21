//
//  NSDictionary+Extra.h
//  Ganbare
//
//  Created by Phung Long on 9/7/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extra)
- (NSDate *)dateForKey:(NSString *)key format:(NSString *)format;
- (NSDate *)unixDateForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSURL *)urlForKey:(NSString *)key;
- (NSInteger)intForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key;
- (NSDecimalNumber *)decimalNumberForKey:(NSString *)key;
- (id)notNullObjectForKey:(id)key;

@end
