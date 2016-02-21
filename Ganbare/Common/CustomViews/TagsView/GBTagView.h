//
//  GBTagView.h
//  Ganbare
//
//  Created by Phung Long on 9/30/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kMaxWidthTagLabel 100

@protocol GBTagViewDelegate <NSObject>

@optional
- (void) removeTagsWithIndex:(NSInteger )index;

@end
@interface GBTagView : UIView
@property (assign, nonatomic) id <GBTagViewDelegate> delegate;
@property (strong, nonatomic) NSString *tagName;
@property (assign, nonatomic) NSInteger index;

@end
