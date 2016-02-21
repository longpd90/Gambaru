//
//  GBAlgorithm.m
//  Ganbare
//
//  Created by Phung Long on 10/7/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBAlgorithm.h"

static GBAlgorithm *_instance;

@implementation GBAlgorithm

- (id)init{
    if (self = [super init]) {

    }
    return self;
}

+ (id)sharedAlgorithm{
    @synchronized(self) {
        
        if (_instance == nil) {
            _instance = [[super alloc] init];
        }
    }
    return _instance;
}

- (NSString *)numberWithCommas:(NSInteger)number integerDigits:(NSInteger)integerDigits {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setUsesGroupingSeparator:YES];
    [formatter setMinimumIntegerDigits:integerDigits];
    NSString *formattedString = [formatter stringFromNumber:[NSNumber numberWithInteger:number]];
    return formattedString;
}

@end
