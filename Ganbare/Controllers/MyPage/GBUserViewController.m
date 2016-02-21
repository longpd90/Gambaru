//
//  GBMypageViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/4/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBUserViewController.h"
#import "GBGanbareTableViewCell.h"
#import "GBGanbareEntity.h"
#import "GBUserEntity.h"
#import "UIImageView+AFNetworking.h"
#import "GBGanbareDetailView.h"
#import "GBEditGanbareViewController.h"
#import "GBRefreshView.h"
#import "GBEditProfileViewController.h"

@interface GBUserViewController ()<GBGanbareDetailViewDelegate>
@property (strong, nonatomic) GBUserEntity *userModel;
@property (strong, nonatomic) GBGanbareDetailView *ganbareDetailView;
@property (strong, nonatomic) GBGanbareEntity *ganbareSelected;
@property (strong,nonatomic) GBRefreshView *pullToRefreshView;

@end

@implementation GBUserViewController

- (void)viewDidLoad {
    _ganbareSearchMode = 1;
    [self setupInterface];
    [super viewDidLoad];
    [self.ganbareTotalStatusView setOurMissionRedStyle];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)setupInterface {
    _userInfoView.layer.borderColor = [UIColor grayColor].CGColor;
    _userInfoView.layer.borderWidth = 1.0f;
    [self.likeButton setImage:[UIImage imageNamed:@"like-user-icon"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"unlike-user-icon"] forState:UIControlStateSelected];
    if (_userID == nil || [_userID isEqualToString:kGBUserID]) {
        _userID = kGBUserID;
        _likeButton.hidden = YES;
        self.mode = GBUserModeMypage;
    } else {
        _editProfileButton.hidden = YES;
        self.mode = GBUserModeOtherUser;
    }
}

#pragma mark - public

- (void)setupInterfaceWithUserInfo {
    [self.coverImageView setImageWithQKURL:_userModel.backgroundUrl placeholderImage:nil withCache:YES];
    [self.userAvatarImageView setImageWithQKURL:_userModel.avatarURL placeholderImage:nil withCache:YES];
    self.favoriteNumberLabel.text = _userModel.favoriteNumber;
    self.favaritedNumberLabel.text = _userModel.favoritedNumber;
    self.sentganbareNumberLabel.text = [NSString stringWithFormat:@"%@GB",[[GBAlgorithm sharedAlgorithm] numberWithCommas:_userModel.sentGanbareNumber integerDigits:24]];
    self.receivedGanbareNumberLabel.text = [NSString stringWithFormat:@"%@GB",[[GBAlgorithm sharedAlgorithm] numberWithCommas:_userModel.receivedGanbareNumber integerDigits:24]] ;
    self.receviedPinNumberLabel.text = _userModel.receivedPinNumber;
    self.sentPinNumberLabel.text = _userModel.sentPinNumber;
    self.userNamelabel.text = _userModel.userName;
    if (self.mode == GBUserModeOtherUser) {
        self.userGanbareLabel.text = [NSString stringWithFormat:@"%@さんのがんばる一覧",_userModel.userName];
    }
    self.loginIdLabel.text = _userModel.loginId;
    self.userProfileTextView.text = _userModel.profile;
    
    self.likeButton.selected = _userModel.favoristUser;
    
}

#pragma mark - call api

- (void)refetchData {
    [super refetchData];
    [self getUserInfo];
}
- (void)getData {
    [super getData];
    if (_getGanbareMode == GBGetGanbareModeNormal) {
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setObject:[NSString stringWithFormat:@"%ld",(long)_ganbareSearchMode] forKey:@"filterType"];
        [params setObject:[NSString stringWithFormat:@"%d",self.skip] forKey:@"skip"];
        [params setObject:[NSString stringWithFormat:@"%d",pagingSize] forKey:@"take"];
        [[GBRequestManager sharedManager] asyncGET:[NSString stringWithFormat:@"%@%@/ganbaru",gbURLUsers,_userID] parameters:params isShowLoadingView:self.isShowLoadingView success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
                NSArray *results = [responseObject objectForKey:@"data"];
                if (results.count < pagingSize)  {
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
    } else {
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setObject:[NSString stringWithFormat:@"%d",self.skip] forKey:@"skip"];
        [params setObject:[NSString stringWithFormat:@"%d",pagingSize] forKey:@"take"];
        [[GBRequestManager sharedManager] asyncGET:[NSString stringWithFormat:@"%@%@/pins",gbURLUsers,_userID] parameters:params isShowLoadingView:self.isShowLoadingView success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
                NSArray *results = [responseObject objectForKey:@"data"];
                if (results.count < pagingSize)  {
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
    }
    
}

- (void)getUserInfo {
    [[GBRequestManager sharedManager] asyncGET:[NSString stringWithFormat:@"%@%@",gbURLUsers,_userID] parameters:nil isShowLoadingView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            _userModel = [[GBUserEntity alloc] initWithDictionary:data];
            _userModel.identifier = [data stringForKey:@"id"];
            _userID = _userModel.identifier;
            [self setupInterfaceWithUserInfo];
        } else {
        }
        [_pullToRefreshView endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error  %@",error);
        [_pullToRefreshView endRefreshing];
        
    }];
}


# pragma mark - Tableview delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"GBGanbareTableViewCell";
    GBGanbareTableViewCell *cell = (GBGanbareTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [UIView loadFromNibNamed:cellID];
    }
    [cell setUserGanbareEffect];
    GBGanbareEntity *gabareModel = [self.items objectAtIndex:indexPath.row];
    [cell setGanbareModel:gabareModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GBGanbareEntity *gabareModel = [self.items objectAtIndex:indexPath.row];
    [self showGanbareDetail:gabareModel];
}

#pragma mark - ScrollDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_pullToRefreshView containingScrollViewDidEndDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect frame  =_pullToRefreshView.frame;
    frame.size.height =scrollView.contentOffset.y;
    [_pullToRefreshView setFrame:frame];
    [_pullToRefreshView layoutIfNeeded];
    
}

#pragma mark - action

- (IBAction)changeSource:(id)sender {
    if ([sender isSelected]) {
        return;
    }
    _sortNewButton.selected = NO;
    _hotButton.selected = NO;
    _noHotButton.selected = NO;
    _expiringButton.selected = NO;
    _expiredButton.selected = NO;
    [sender setSelected:YES];
    _ganbareSearchMode = [sender tag] + 1;
    _getGanbareMode = GBGetGanbareModeNormal;
    [self refetchData];
    
}

- (IBAction)editProfileButtonclicked:(id)sender {
    [self performSegueWithIdentifier:@"showEditProfileSegue" sender:self];
}

- (IBAction)searchButtonClicked:(id)sender {
    
}

- (IBAction)creatButtonClicked:(id)sender {
    _ganbareEditMode = GBGanbareEditModeNew;
    [self performSegueWithIdentifier:@"showEditGanbareSegue" sender:self];
}

- (IBAction)likeButtonClicked:(id)sender {
    if (self.likeButton.selected) {
        [self.userModel removeUserFromFavorite];
    } else {
        [self.userModel addUserToFavorite];
    }
}

- (IBAction)piningGanbareButtonClicked:(id)sender {
    if ([sender isSelected]) {
        return;
    }
    _sortNewButton.selected = NO;
    _hotButton.selected = NO;
    _noHotButton.selected = NO;
    _expiringButton.selected = NO;
    [sender setSelected:YES];
    _getGanbareMode = GBGetGanbareModePin;
    [self refetchData];
}

- (void)showGanbareDetail:(GBGanbareEntity *)gabare {
    GBGanbareDetailView *ganbareDetailView = [UIView loadFromNibNamed:@"GBGanbareDetailView"];
    ganbareDetailView.delegate = self;
    ganbareDetailView.ganbareID = gabare.identifier;
    [ganbareDetailView show];
}

#pragma mark - notification

- (void)itemWasChanged:(NSNotification *)notification
{
    [super itemWasChanged:notification];
    NSDictionary *userInfo = notification.userInfo;
    GBItem *object = [userInfo objectForKey:@"object"];
    if ([self.userModel.identifier isEqualToString:object.identifier]) {
        [self.userModel setValuesFromArray:userInfo[@"values"]];
    }
    [self setupInterfaceWithUserInfo];
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
    if ([segue.identifier isEqualToString:@"showEditProfileSegue"]) {
        GBEditProfileViewController *editProfileViewController = (GBEditProfileViewController *)segue.destinationViewController;
        editProfileViewController.userEntity = _userModel;
    }
    
}

@end
