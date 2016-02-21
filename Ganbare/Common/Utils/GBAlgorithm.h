//
//  GBAlgorithm.h
//  Ganbare
//
//  Created by Phung Long on 10/7/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBAlgorithm : NSObject

+ (id)sharedAlgorithm;
- (NSString *)numberWithCommas:(NSInteger)number integerDigits:(NSInteger)integerDigits ;
@end
