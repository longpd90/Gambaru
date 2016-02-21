//
//  GBRefreshView.h
//  Ganbare
//
//  Created by Phung Long on 10/1/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBRefreshView : UIRefreshControl
- (void)containingScrollViewDidEndDragging:(UIScrollView *)containingScrollView;

@end
