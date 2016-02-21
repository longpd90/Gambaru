//
//  GBBaseTableViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBBaseViewController.h"

#define pagingSize 5

typedef enum : NSUInteger {
    GBItemsTableViewStateNormal = 0,
    GBItemsTableViewStateLoadingMoreContent
} GBItemsTableViewViewState;

@interface GBBaseTableViewController : GBBaseViewController

@property (assign, nonatomic) GBItemsTableViewViewState tableViewState;
@property (strong, nonatomic) IBOutlet UITableView *itemsTableView;
@property (strong, nonatomic) NSMutableArray *items;
@property (assign, nonatomic) int skip;
@property (assign, nonatomic) BOOL canLoadMore;
@property (assign, nonatomic) BOOL isShowLoadingView;

- (void)refreshView;
- (void)getData ;
- (void)refetchData;
- (void)itemWasChanged:(NSNotification *)notification;
@end
