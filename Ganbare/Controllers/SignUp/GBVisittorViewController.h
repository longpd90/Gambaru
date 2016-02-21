//
//  GBVisittorViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseTableViewController.h"
#import "GBGanbareStatusView.h"
#import "GBGanbareToolBarView.h"
#import "GBGanbareSearchViewBar.h"
#import "GBGlobalBorderView.h"

typedef enum {
    GBTypeModeSort = 0,
    GBTypeModeFilter,
} GBTypeMode;

@interface GBVisittorViewController : GBBaseTableViewController

@property (weak, nonatomic) IBOutlet GBDynamicLabel *totalGanbareLabel;
@property (weak, nonatomic) IBOutlet GBGanbareSearchViewBar *ganbarTopMenuView;
@property (weak, nonatomic) IBOutlet GBGanbareToolBarView *ganbareToolBarView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet GBGlobalBorderView *tipView;
- (IBAction)signupButtonClicked:(id)sender;
- (IBAction)cancelTipButtonClicked:(id)sender;

@end
