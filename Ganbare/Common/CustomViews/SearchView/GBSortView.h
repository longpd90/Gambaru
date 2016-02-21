//
//  GBSortView.h
//  Ganbare
//
//  Created by Phung Long on 9/10/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GBSortView;
@protocol GBSortViewDelegate <NSObject>

@optional
- (void)didSelectSortTile:(NSInteger)index;

@end

@interface GBSortView : UIView
@property (assign, nonatomic)id<GBSortViewDelegate>delegate;
@property (strong, nonatomic) NSArray *sortTiles;
@property (weak, nonatomic) IBOutlet UITableView *sortTablewView;
- (void)show;
@end
