//
//  GBBaseTableViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseTableViewController.h"
#import "GBRefreshView.h"
#import "GBGanbareEntity.h"
#import "GBItem.h"

@interface GBBaseTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) GBRefreshView *pullToRefreshView;
@property (strong, nonatomic) UIView *	loadingMoreContentView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation GBBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewState = GBItemsTableViewStateNormal;
    _itemsTableView.delegate = self;
    _itemsTableView.dataSource = self;
    [self creatRefreshView];
    [self refetchData];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(itemWasChanged:)
                                                 name:kGBItemWasChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wasAddedGanbare:)
                                                 name:kGBWasAddedGanbareNotification
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGBItemWasChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGBWasAddedGanbareNotification object:nil];

}

- (void) creatRefreshView {
    CGFloat customRefreshControlHeight = 50.0f;
    CGFloat customRefreshControlWidth = CGRectGetWidth(self.itemsTableView.frame);
    _pullToRefreshView = [[GBRefreshView alloc]initWithFrame:CGRectMake(0.0, -customRefreshControlHeight, customRefreshControlWidth, customRefreshControlHeight)];
    [_pullToRefreshView addTarget:self action:@selector(reloadView:) forControlEvents:UIControlEventValueChanged];
    [self.itemsTableView addSubview:_pullToRefreshView];
}

- (void)reloadView:(id)sender {
    if ([_pullToRefreshView isRefreshing]) {
        [_items removeAllObjects];
        [self refetchData];
    }
}

- (void)getData {
    if (!_items) {
        _items = [NSMutableArray new];
    }
    if (self.skip == 0) {
        self.isShowLoadingView = YES;
    } else if (self.skip > 0) {
        self.isShowLoadingView = NO;
    }
}

- (void)refetchData
{
    self.skip = 0;
    [self.items removeAllObjects];
    [self.itemsTableView reloadData];
    [self getData];
}

#pragma mark - public

- (void)refreshView {
    [self.itemsTableView reloadData];
    [_pullToRefreshView endRefreshing];
    self.tableViewState = GBItemsTableViewStateNormal;
}

- (void)setTableViewState:(GBItemsTableViewViewState)tableViewState {
    _tableViewState = tableViewState;
    switch (tableViewState) {
        case GBItemsTableViewStateNormal:
        {
            self.itemsTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            self.itemsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            [_pullToRefreshView endRefreshing];
            break;
        }
        case GBItemsTableViewStateLoadingMoreContent:
        {
            [self loadMoreDatas];
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - notification

- (void)itemWasChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    GBItem *object = [userInfo objectForKey:@"object"];
    
    for (GBItem *item in self.items) {
        if ([item isKindOfClass:[GBGanbareEntity class]]) {
            GBGanbareEntity *ganbareItem = (GBGanbareEntity *)item;
            if ([ganbareItem.identifier isEqualToString:object.identifier]) {
                [ganbareItem setValuesFromArray:userInfo[@"values"]];
            }
            if ([ganbareItem.user.identifier isEqualToString:object.identifier]) {
                [ganbareItem.user setValuesFromArray:userInfo[@"values"]];
            }
        }
        
        if ([item isKindOfClass:[GBUserEntity class]]) {
            if ([item.identifier isEqualToString:object.identifier]) {
                [item setValuesFromArray:userInfo[@"values"]];
            }
        }

        [self.itemsTableView reloadData];
    }
}

- (void)wasAddedGanbare:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    GBItem *object = [userInfo objectForKey:@"object"];
    for (GBItem *item in self.items) {
        if ([item isKindOfClass:[GBGanbareEntity class]]) {
            GBGanbareEntity *ganbareItem = (GBGanbareEntity *)item;
            if ([ganbareItem.identifier isEqualToString:object.identifier]) {
                [ganbareItem setValuesFromArray:userInfo[@"values"]];
            }
        }
    }
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kGBGanbareTableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"GBGanbareTableViewCell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

// load more data
- (void)scrollViewDidScroll: (UIScrollView *)scroll {
    // UITableView only moves in one direction, y axis
    CGFloat currentOffset = scroll.contentOffset.y;
    CGFloat maximumOffset = scroll.contentSize.height - scroll.frame.size.height;
    
    // Change 10.0 to adjust the distance from bottom
    if (maximumOffset - currentOffset <= 0.0) {
        if (self.tableViewState == GBItemsTableViewStateNormal) {
            self.tableViewState = GBItemsTableViewStateLoadingMoreContent;
        }
    }
}

- (void)loadMoreDatas {
    if (!_loadingMoreContentView) {
        _loadingMoreContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.itemsTableView.width, 46)];
        _loadingMoreContentView.backgroundColor = [UIColor lightGrayColor];
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 46, 46)];
        _indicatorView.center = _loadingMoreContentView.centerOfView;
        [_indicatorView startAnimating];
        [_loadingMoreContentView addSubview:_indicatorView];
    }
    if (self.canLoadMore) {
        self.itemsTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.itemsTableView.tableFooterView = self.loadingMoreContentView;
        self.skip += 1;
        [self getData];
    }
    
}

@end
