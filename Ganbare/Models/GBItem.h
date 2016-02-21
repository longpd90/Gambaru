//
//  GBItem.h
//  Ganbare
//
//  Created by Phung Long on 10/23/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBItem : NSObject

@property (strong, nonatomic) NSString *identifier;

- (void)setValuesFromArray:(NSArray *)array;
@end
