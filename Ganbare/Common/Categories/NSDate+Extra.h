//
//  NSDate+Extra.h
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNSDateOneMinuteInterval (60)
#define kNSDateOneHourInterval (3600)
#define kNSDateOneDayInterval (3600 * 24)
#define kNSDateOneWeekInterval (3600 * 24 * 7)
#define kNSDateOneMonthInterval (3600 * 24 * 31)
#define kNSDateOneYearInterval (3600 * 24 * 356)
@interface NSDate (Extra)
- (NSString *) intervalInStringSinceDate:(NSDate *)date;
- (NSString *) shortIntervalInStringSinceDate:(NSDate *)date;
- (NSString *) stringValueFormattedBy:(NSString *)formatString;
- (NSComparisonResult) compareMonth:(NSDate *)date;
- (NSComparisonResult) compareDay:(NSDate *)date;
- (NSComparisonResult) compareHour:(NSDate *)date;
- (NSDate *) dateByAddingMonth:(NSInteger) month;
- (NSDate *) monthBegin;
- (NSDate *) dayBegin;
- (NSDate *) monthEnd;
- (NSDate *) dayEnd;
- (int) numberOfWeeksInMonth;
- (BOOL)isEarlierThanDate:(NSDate *)date;
- (BOOL)isLaterThanDate:(NSDate *)date;
+ (NSDate *)tomorrow;
- (BOOL)isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
-(NSDate*)earlierDateWithTimeInterval:(NSTimeInterval)interval;


@end
