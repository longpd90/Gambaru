//
//  GBItem.m
//  Ganbare
//
//  Created by Phung Long on 10/23/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBItem.h"

@implementation GBItem

- (void)setValuesFromArray:(NSArray *)array
{
    for (NSDictionary *value in array) {
        NSString *key = [value objectForKey:@"key"];
        SEL selector = NSSelectorFromString(key);
        if ([self respondsToSelector:selector]) {
            [self setValue:[value objectForKey:@"value"] forKey:key];
        }
    }
}

@end
