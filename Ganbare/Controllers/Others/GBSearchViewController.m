//
//  GBSearchViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/11/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBSearchViewController.h"
#import "GBGanbareEntity.h"
#import "GBGanbareTableViewCell.h"
#import "GBUserTableViewCell.h"
#import "GBUserViewController.h"
#import "GBGanbareDetailView.h"
#import "GBEditGanbareViewController.h"

@interface GBSearchViewController ()<GBGanbareDetailViewDelegate>
@property (strong, nonatomic) GBUserEntity *user;
@property (strong, nonatomic) GBGanbareEntity *ganbareSelected;
@end

@implementation GBSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView.height = 54;
    self.itemsTableView.tableHeaderView = self.headerView;
    self.itemsTableView.tableHeaderView.height = self.headerView.height;
    self.ganbareSourceView.hidden = YES;
    if (self.mode == GBSearchModeVisitor) {
        self.tableViewSpaceToBottomConstraint.constant = 0;
    }
}

#pragma mark - call api

- (void)getData {
    [super getData];
    if (_userButton.selected) {
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setObject:_searchTextField.text forKey:@"username"];
        [params setObject:[NSString stringWithFormat:@"%d",self.skip] forKey:@"skip"];
        [params setObject:[NSString stringWithFormat:@"%d",pagingSize] forKey:@"take"];
        
        [[GBRequestManager sharedManager] asyncGET:[NSString stringFromConst:gbURLUsers] parameters:params isShowLoadingView:self.isShowLoadingView success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
                
                NSArray *results = [responseObject objectForKey:@"data"];
                if (results.count < pagingSize)  {
                    self.canLoadMore = NO;
                } else {
                    self.canLoadMore = YES;
                }
                if (results.count > 0) {
                    for (NSDictionary *userDictionary in results) {
                        GBUserEntity *usreEntity = [[GBUserEntity alloc] initWithDictionary:userDictionary];
                        [self.items addObject:usreEntity];
                    }
                }
            }
            [self refreshView];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            self.tableViewState = GBItemsTableViewStateNormal;

        }];
    } else {
        NSMutableDictionary *params = [NSMutableDictionary new];
        [params setObject:@"1" forKey:@"filterType"];
        [params setObject:[NSString stringWithFormat:@"%d",self.skip] forKey:@"skip"];
        [params setObject:[NSString stringWithFormat:@"%d",pagingSize] forKey:@"take"];
        [params setObject:_searchTextField.text forKey:@"searchContent"];
        NSLog(@"params :%@",params);

        [[GBRequestManager sharedManager] asyncGET:[NSString stringFromConst:gbURLGanbare] parameters:params isShowLoadingView:self.isShowLoadingView success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response :%@",responseObject);

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
    }
}

#pragma mark - action

- (IBAction)gobackButtonClicked:(id)sender {
    [self goBack:sender];
}

- (IBAction)creatButtonClicked:(id)sender {
    if ([kGBUserID isEqualToString:@""] ||
        kGBUserID == nil) {
        return;
    }
    [self performSegueWithIdentifier:@"showEditGanbareSegue" sender:self];
}

- (IBAction)searchButtonClicked:(id)sender {
    [self refetchData];
    [self hiddenKeyboard];
}

- (IBAction)changeSource:(id)sender {
    if ([sender isSelected]) {
        return;
    }
    _userButton.selected = NO;
    _ganbareButton.selected = NO;
    [sender setSelected:YES];
    self.searchTextField.text = nil;
    if (_userButton.selected) {
        self.headerView.height = 54;
        self.ganbareSourceView.hidden = YES;
        [self refetchData];
    } else {
        self.headerView.height = 108;
        self.ganbareSourceView.hidden = NO;
        [self changeSoucreGanbare:_ganbareNewButton];
    }
    self.itemsTableView.tableHeaderView = self.headerView;
    self.itemsTableView.tableHeaderView.height = self.headerView.height;
    [self hiddenKeyboard];

}

- (IBAction)changeSoucreGanbare:(id)sender {
    _ganbareNewButton.selected = NO;
    _hotButton.selected = NO;
    _noHotButton.selected = NO;
    _expiringButton.selected = NO;
    [sender setSelected:YES];
    [self refetchData];
    [self hiddenKeyboard];
}

- (void)showUser {
    [self performSegueWithIdentifier:@"showUserViewSegue" sender:self];
}

- (void)showGanbare:(GBGanbareEntity *)gabare {
    GBGanbareDetailView *ganbareDetailView = [UIView loadFromNibNamed:@"GBGanbareDetailView"];
    ganbareDetailView.delegate = self;
    ganbareDetailView.ganbareID = gabare.identifier;
    [ganbareDetailView show];
}

#pragma mark - ganbare detail view delegate

- (void)editGanbare:(GBGanbareEntity *)ganbare {
    _ganbareSelected = ganbare;
    [self performSegueWithIdentifier:@"showEditGanbareSegue" sender:self];
}

# pragma mark - Tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_userButton.selected) {
        return 120;
    } else {
        return kGBGanbareTableViewCellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_userButton.selected) {
        static NSString *cellID = @"GBUserTableViewCell";
        GBUserTableViewCell *cell = (GBUserTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [UIView loadFromNibNamed:cellID];
        }
        GBUserEntity *userModel = [self.items objectAtIndex:indexPath.row];
        [cell setUserModel:userModel];
        return cell;
    } else {
        static NSString *cellID = @"GBGanbareTableViewCell";
        GBGanbareTableViewCell *cell = (GBGanbareTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [UIView loadFromNibNamed:cellID];
        }
        GBGanbareEntity *gabareModel = [self.items objectAtIndex:indexPath.row];
        [cell setGanbareModel:gabareModel];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([kGBUserID isEqualToString:@""] ||
        kGBUserID == nil) {
        return;
    }
    if (_userButton.selected) {
        GBUserEntity *userSelected = [self.items objectAtIndex:indexPath.row];
        _user = userSelected;
        [self showUser];
    } else {
        GBGanbareEntity *ganbareSelected = [self.items objectAtIndex:indexPath.row];
        [self showGanbare:ganbareSelected];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showUserViewSegue"]) {
        GBUserViewController *userViewController = (GBUserViewController *)segue.destinationViewController;
        userViewController.userID = _user.identifier;
    }
    if ([segue.identifier isEqualToString:@"showEditGanbareSegue"]) {
        GBEditGanbareViewController *editGanbareViewController = (GBEditGanbareViewController *)segue.destinationViewController;
        editGanbareViewController.mode = GBGanbareEditModeEdit;
        editGanbareViewController.ganbareModel = _ganbareSelected;
    }
}

@end
