//
//  GBHomePageViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBHomePageViewController.h"
#import "GBGanbareEntity.h"
#import "GBGanbareTableViewCell.h"
#import "GBSortView.h"
#import "GBGanbareDetailView.h"
#import "GBGlobalPickerView.h"
#import "GBEditGanbareViewController.h"

@interface GBHomePageViewController ()<GBGanbareSearchViewBarDelegate,GBSortViewDelegate,GBGanbareDetailViewDelegate,GBGlobalPickerViewDelegate>
@property (strong, nonatomic)GBSortView *sortView;
@property (assign, nonatomic) GBTypeMode typeMode;
@property (strong, nonatomic) NSString *sortTypeValue;
@property (strong, nonatomic) NSString *filterTypeValue;
@property (strong, nonatomic) GBGlobalPickerView *pickerView;
@property (strong, nonatomic) NSDate *timeStamp;
@property (strong, nonatomic) GBGanbareEntity *ganbareSelected;
@property (nonatomic) GBGanbareEditMode ganbareEditMode;

@end

@implementation GBHomePageViewController

- (void)viewDidLoad {
    _filterTypeValue = @"1";
    _sortTypeValue = @"1";
    _getGanbareMode = GBGetGanbareModeFavorite;
    _ganbarTopMenuView.filterTypeLabel.text = [[GBGlobalConts FILTER_TYPE_USER_MAP] objectForKey:_filterTypeValue];
    [super viewDidLoad];
    self.ganbarTopMenuView.delegate = self;
    self.ganbarTopMenuView.mode = GBSearchViewModeHome;
    // Do any additional setup after loading the view.
}

#pragma mark - public

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _sortView.width = self.view.width;

}
#pragma mark - call api

- (void)getData {    
    [super getData];
    if (_getGanbareMode == GBGetGanbareModeNormal) {
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setObject:[NSString stringWithFormat:@"%d",_filterTypeValue.intValue - 2] forKey:@"filterType"];
        [params setObject:_sortTypeValue forKey:@"sortType"];
        [params setObject:[NSString stringWithFormat:@"%d",self.skip] forKey:@"skip"];
        [params setObject:[NSString stringWithFormat:@"%d",pagingSize] forKey:@"take"];
        [[GBRequestManager sharedManager] asyncGET:[NSString stringFromConst:gbURLGanbare] parameters:params isShowLoadingView:self.isShowLoadingView success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
                NSArray *results = [responseObject objectForKey:@"data"];
                if (results.count < pagingSize) {
                    self.canLoadMore = NO;
                } else {
                    self.canLoadMore = YES;

                }
                if (results.count > 0) {
                    for (NSDictionary *ganbareDictionary in results) {
                        GBGanbareEntity *ganbare = [[GBGanbareEntity alloc] initWithDictionary:ganbareDictionary];
                        [self.items addObject:ganbare];
                    }
                }
            }
            [self refreshView];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.tableViewState = GBItemsTableViewStateNormal;
        }];
    } else if (_getGanbareMode == GBGetGanbareModePin) {
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setObject:[NSString stringWithFormat:@"%d",self.skip] forKey:@"skip"];
        [params setObject:[NSString stringWithFormat:@"%d",pagingSize] forKey:@"take"];
        [[GBRequestManager sharedManager] asyncGET:[NSString stringWithFormat:@"%@%@/pins",gbURLUsers,kGBUserID] parameters:params isShowLoadingView:self.isShowLoadingView success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
                NSArray *results = [responseObject objectForKey:@"data"];
                if (results.count < pagingSize) {
                    self.canLoadMore = NO;
                } else {
                    self.canLoadMore = YES;
                }
                if (results.count > 0) {
                    for (NSDictionary *ganbareDictionary in results) {
                        GBGanbareEntity *ganbare = [[GBGanbareEntity alloc] initWithDictionary:ganbareDictionary];
                        [self.items addObject:ganbare];
                    }
                }
            }
            [self refreshView];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.tableViewState = GBItemsTableViewStateNormal;

        }];
    } else if (_getGanbareMode == GBGetGanbareModeFavorite) {
        
        NSMutableDictionary *params = [NSMutableDictionary new];
        if (_timeStamp) {
            [params setObject:[_timeStamp stringValueFormattedBy:@"yyyyMMddHHmmssSSS"] forKey:@"timestamp"];
        }
        [params setObject:[NSString stringWithFormat:@"%d",pagingSize] forKey:@"take"];
        
        [[GBRequestManager sharedManager] asyncGET:[NSString stringWithFormat:@"%@%@/favorites/ganbaru",gbURLUsers,kGBUserID] parameters:params isShowLoadingView:self.isShowLoadingView success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
                NSArray *results = [responseObject objectForKey:@"data"];
                if (results.count < pagingSize) {
                    self.canLoadMore = NO;
                } else {
                    self.canLoadMore = YES;
                }
                if (results.count > 0) {
                    for (NSDictionary *ganbareDictionary in results) {
                        GBGanbareEntity *ganbare = [[GBGanbareEntity alloc] initWithDictionary:ganbareDictionary];
                        if ( [results indexOfObject:ganbareDictionary] == [results count] - 1) {
                            _timeStamp = ganbare.createDate;
                        }
                        [self.items addObject:ganbare];
                    }
                }
            }
            [self refreshView];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.tableViewState = GBItemsTableViewStateNormal;

        }];
    }

}


# pragma mark - Tableview delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"GBGanbareTableViewCell";
    GBGanbareTableViewCell *cell = (GBGanbareTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [UIView loadFromNibNamed:cellID];
    }
    [cell setBackgroundEffect];
    GBGanbareEntity *gabareModel = [self.items objectAtIndex:indexPath.row];
    [cell setGanbareModel:gabareModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GBGanbareEntity *gabareModel = [self.items objectAtIndex:indexPath.row];
    [self showGanbareDetail:gabareModel];
}

#pragma mark - action
- (void)showGanbareDetail:(GBGanbareEntity *)gabare {
    
    GBGanbareDetailView *ganbareDetailView = [UIView loadFromNibNamed:@"GBGanbareDetailView"];
    ganbareDetailView.delegate = self;
    
    ganbareDetailView.ganbareID = gabare.identifier;
    [ganbareDetailView show];
}

#pragma mark - ganbare detail view delegate

- (void)editGanbare:(GBGanbareEntity *)ganbare {
    _ganbareSelected = ganbare;
    _ganbareEditMode = GBGanbareEditModeEdit;
    [self performSegueWithIdentifier:@"showEditGanbareSegue" sender:self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEditGanbareSegue"]) {
        GBEditGanbareViewController *editGanbareViewController = (GBEditGanbareViewController *)segue.destinationViewController;
        editGanbareViewController.mode = _ganbareEditMode;
        if (_ganbareEditMode == GBGanbareEditModeEdit) {
            editGanbareViewController.ganbareModel = _ganbareSelected;
        }
    }
}
#pragma mark - Sort View

- (void)showSortType {
    _typeMode = GBTypeModeSort;
    [self showPickerView];
    
}

- (void)showFilterType {
    _typeMode = GBTypeModeFilter;
    [self showPickerView];
}

- (void)showPickerView {
    if (!self.pickerView) {
        self.pickerView = [[GBGlobalPickerView alloc] init];
        self.pickerView.delegate = self;
    }
    if (_typeMode == GBTypeModeSort) {
        NSArray *sortModes = [NSArray arrayWithObjects:@"NEW",@"多い",@"少ない", @"期限近い", nil];
        [self.pickerView setPickerData:sortModes];
        if (_sortTypeValue != nil && ![_sortTypeValue isEqualToString:@""]) {
            [self.pickerView setSelectedIndex:_sortTypeValue.intValue - 1];
        }
    } else if (_typeMode == GBTypeModeFilter){
        NSArray *filterModes = [NSArray arrayWithObjects:@"お気に入り",@"ピン止め",@"HOT",@"NEW",@"期限間近",@"タグクラウド", nil];
        [self.pickerView setPickerData:filterModes];
        if (_filterTypeValue != nil && ![_filterTypeValue isEqualToString:@""]) {
            [self.pickerView setSelectedIndex:_filterTypeValue.intValue - 1];
        }
    }
    
    [self.pickerView show];
}

- (void)donePickerView:(GBGlobalPickerView *)pickerView selectedIndex:(NSInteger)selectedIndex {
    
    if (_typeMode == GBTypeModeSort) {
        _sortTypeValue =  [NSString stringWithFormat:@"%ld",selectedIndex+1];
        _ganbarTopMenuView.sortTypeLabel.text = [[GBGlobalConts SORT_TYPE_MAP] objectForKey:_sortTypeValue];
        
    } else {
        if (selectedIndex < 2) {
            if (selectedIndex == 0) {
                _getGanbareMode = GBGetGanbareModeFavorite;
            } else {
                _getGanbareMode = GBGetGanbareModePin;
            }
        } else {
            _getGanbareMode = GBGetGanbareModeNormal;
        }
        _filterTypeValue =  [NSString stringWithFormat:@"%ld",selectedIndex+1];
        _ganbarTopMenuView.filterTypeLabel.text = [[GBGlobalConts FILTER_TYPE_USER_MAP] objectForKey:_filterTypeValue];

    }
    [self refetchData];
    
}
- (void)creatGanbare {
    _ganbareEditMode = GBGanbareEditModeNew;
    [self performSegueWithIdentifier:@"showEditGanbareSegue" sender:self];
}

- (void)showSearchView {
    [self performSegueWithIdentifier:@"showSearchViewSegue" sender:self];
}

@end
