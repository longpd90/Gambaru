//
//  GBSearchViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/11/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseTableViewController.h"
#import "GBSortTypeSearchButton.h"
#import "GBGlobalBorderView.h"

typedef enum {
    GBSearchModeNormal = 0,
    GBSearchModeVisitor
} GBSearchMode;

@interface GBSearchViewController : GBBaseTableViewController
@property (nonatomic) GBSearchMode mode;
@property (weak, nonatomic) IBOutlet GBGlobalBorderView *ganbareSourceView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet GBSortTypeSearchButton *userButton;
@property (weak, nonatomic) IBOutlet GBSortTypeSearchButton *ganbareButton;
@property (weak, nonatomic) IBOutlet GBSortTypeSearchButton *ganbareNewButton;
@property (weak, nonatomic) IBOutlet GBSortTypeSearchButton *hotButton;
@property (weak, nonatomic) IBOutlet GBSortTypeSearchButton *noHotButton;
@property (weak, nonatomic) IBOutlet GBSortTypeSearchButton *expiringButton;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewSpaceToBottomConstraint;

- (IBAction)gobackButtonClicked:(id)sender;
- (IBAction)changeSource:(id)sender;
- (IBAction)searchButtonClicked:(id)sender;
- (IBAction)changeSoucreGanbare:(id)sender;

@end
