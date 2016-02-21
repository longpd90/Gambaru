//
//  GanbareCommentView.h
//  Ganbare
//
//  Created by Phung Long on 9/28/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum GBUserMode : NSInteger {
    GBCommentModePolygon = 0,
    GBCommentModeComment
} GBCommentMode;

@interface GBGanbareCommentView : UIView

@property (nonatomic) GBCommentMode mode;

- (id)initWithMode:(GBCommentMode )mode;

@end
