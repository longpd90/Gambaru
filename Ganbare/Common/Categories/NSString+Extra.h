//
//  NSString+Extra.h
//  Ganbare
//
//  Created by Phung Long on 9/4/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extra)
+ (NSString *)stringFromConst:(NSString const *)constValue;
- (NSString *)encyptMD5;
- (NSString *)removeWhitePlace;
@end
