//
//  GBVisittorViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBVisittorViewController.h"
#import "GBGanbareEntity.h"
#import "GBGanbareTableViewCell.h"
#import "GBSortView.h"
#import "GBSearchViewController.h"
#import "GBGlobalPickerView.h"

@interface GBVisittorViewController ()<GBGanbareSearchViewBarDelegate,GBGlobalPickerViewDelegate>

@property (strong, nonatomic)GBSortView *sortView;
@property (strong, nonatomic) NSString *sortTypeValue;
@property (strong, nonatomic) NSString *filterTypeValue;
@property (assign, nonatomic) GBTypeMode typeMode;
@property (strong, nonatomic) GBGlobalPickerView *pickerView;

@end

@implementation GBVisittorViewController

- (void)viewDidLoad {
    _filterTypeValue = @"1";
    _sortTypeValue = @"1";
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"gotoSignup" object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self showSignupViewController];
    }];
    self.ganbarTopMenuView.delegate = self;
    self.ganbarTopMenuView.mode = GBSearchViewModeVisitor;
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap)];
    [self.overlayView addGestureRecognizer:singleFingerTap];

    if (kGBTotal22NumberGanbareKey != nil) {
        self.totalGanbareLabel.text = kGBTotal22NumberGanbareValue;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    // check show tip if need
    if ([kGBShowTip isEqualToString:kGBDoNotShowTipValue]) {
        self.overlayView.hidden = YES;
        self.tipView.hidden = YES;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _sortView.width = self.view.width;
}

#pragma mark - action
- (void)handleSingleTap {
    self.overlayView.hidden = YES;
    self.tipView.hidden = YES;
}

- (IBAction)signupButtonClicked:(id)sender {
    [self showSignupViewController];
}

- (IBAction)cancelTipButtonClicked:(id)sender {
    self.overlayView.hidden = YES;
    self.tipView.hidden = YES;
    [kGBUserDefaults setObject:kGBDoNotShowTipValue forKey:kGBShowTipKey];
}

#pragma mark - call api

- (void)getData {
    [super getData];
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:_filterTypeValue forKey:@"filterType"];
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
            self.totalGanbareLabel.text = kGBTotal22NumberGanbareValue;
        }
        [self refreshView];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.tableViewState = GBItemsTableViewStateNormal;
        
    }];
}

# pragma mark - Tableview delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"GBGanbareTableViewCell";
    GBGanbareTableViewCell *cell = (GBGanbareTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellID];

    if (!cell) {
        cell = [UIView loadFromNibNamed:cellID];
    }
    GBGanbareEntity *gabareModel = [self.items objectAtIndex:indexPath.row];
    [cell setGanbareModel:gabareModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

# pragma mark - notification

- (void)showSignupViewController {
    [self performSegueWithIdentifier:@"GBShowSignupSegue" sender:self];
}

#pragma mark - navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSearchViewSegue"]) {
        GBSearchViewController *searchViewController = (GBSearchViewController *)segue.destinationViewController;
        searchViewController.mode = GBSearchModeVisitor;
    }
}

#pragma mark - picker view

- (void)showPickerView {
    if (!self.pickerView) {
        self.pickerView = [[GBGlobalPickerView alloc] init];
        self.pickerView.delegate = self;
    }
    if (_typeMode == GBTypeModeSort) {
        NSArray *sortModes = [NSArray arrayWithObjects:@"NEW",@"多い",@"少ない", @"期限近い",nil];
        [self.pickerView setPickerData:sortModes];
        if (_sortTypeValue != nil && ![_sortTypeValue isEqualToString:@""]) {
            [self.pickerView setSelectedIndex:_sortTypeValue.intValue - 1];
        }
    } else if (_typeMode == GBTypeModeFilter){
        NSArray *filterModes = [NSArray arrayWithObjects:@"HOT",@"NEW",@"期限間近",@"タグクラウド", nil];
        [self.pickerView setPickerData:filterModes];
        if (_filterTypeValue != nil && ![_filterTypeValue isEqualToString:@""]) {
            [self.pickerView setSelectedIndex:_filterTypeValue.intValue - 1];
        }
    }
    [self.pickerView show];
}


#pragma mark - Sort View

- (void)showSortType {
//    if (!_sortView) {
//        [self initSortView];
//    }
//    if (_sortView.hidden == YES) {
//        _typeMode = GBTypeModeSort;
//        _sortView.sortTiles = [NSArray arrayWithObjects:@"HOT",@"NEW",@"EXPIRING", nil];
//        [self showSortView];
//    } else {
//        [self hiddenSortView];
//    }
    _typeMode = GBTypeModeSort;
    [self showPickerView];
}

- (void)showFilterType {
//    if (!_sortView) {
//        [self initSortView];
//    }
//    if (_sortView.hidden == YES) {
//        _typeMode = GBTypeModeFilter;
//        _sortView.sortTiles = [NSArray arrayWithObjects:@"HOT",@"NEW",@"EXPIRING",@"TAG", nil];
//        [self showSortView];
//    } else {
//        [self hiddenSortView];
//    }
    _typeMode = GBTypeModeFilter;
    [self showPickerView];
    
}


- (void)donePickerView:(GBGlobalPickerView *)pickerView selectedIndex:(NSInteger)selectedIndex {
    
    if (_typeMode == GBTypeModeSort) {
        _sortTypeValue =  [NSString stringWithFormat:@"%ld",selectedIndex+1];
        _ganbarTopMenuView.sortTypeLabel.text = [[GBGlobalConts SORT_TYPE_MAP] objectForKey:_sortTypeValue];
        
    } else {
        _filterTypeValue =  [NSString stringWithFormat:@"%ld",selectedIndex+1];
        _ganbarTopMenuView.filterTypeLabel.text = [[GBGlobalConts FILTER_TYPE_VISITOR_MAP] objectForKey:_filterTypeValue];
    }
    [self refetchData];

}


//- (void) initSortView {
//    _sortView = [UIView loadFromNibNamed:@"GBSortView"];
//    _sortView.delegate = self;
//    _sortView.y = -_sortView.height + _ganbarTopMenuView.bottomYPoint;
//    _sortView.hidden = YES;
//    [self.view addSubview:_sortView];
//}
//
//- (void)showSortView {
//    self.sortView.hidden = NO;
//    [UIView animateWithDuration:0.5 animations:^{
//        _sortView.y = _ganbarTopMenuView.bottomYPoint;
//    } completion:^(BOOL finished) {
//        
//    }];
//}
//
//- (void)hiddenSortView {
//    [UIView animateWithDuration:0.5 animations:^{
//        _sortView.y = -_sortView.height;
//    } completion:^(BOOL finished) {
//        _sortView.hidden = YES;
//    }];
//}

//- (void)didSelectSortTile:(NSInteger)index {
//    [self hiddenSortView];
//    if (_typeMode == GBTypeModeSort) {
//        _sortTypeValue =  [NSString stringWithFormat:@"%ld",index+1];
//        _ganbarTopMenuView.sortTypeLabel.text = [[GBGlobalConts SORT_TYPE_MAP] objectForKey:_sortTypeValue];
//
//    } else {
//        _filterTypeValue =  [NSString stringWithFormat:@"%ld",index+1];
//        _ganbarTopMenuView.filterTypeLabel.text = [[GBGlobalConts FILTER_TYPE_MAP] objectForKey:_filterTypeValue];
//    }
//    [self refetchData];
//}

- (void)showSearchView {
    [self performSegueWithIdentifier:@"showSearchViewSegue" sender:self];
}

@end
