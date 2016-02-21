//
//  GBGanbarTopMenuView.h
//  Ganbare
//
//  Created by Phung Long on 9/7/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GBSearchViewModeHome = 0,
    GBSearchViewModeVisitor
} GBSearchViewMode;

@class GBGanbareSearchViewBar;
@protocol GBGanbareSearchViewBarDelegate <NSObject>

@optional
- (void)showSortType;
- (void)showFilterType;
- (void)showSearchView;
- (void)creatGanbare;

@end

@interface GBGanbareSearchViewBar : UIView
@property (weak, nonatomic)id<GBGanbareSearchViewBarDelegate> delegate;
@property (nonatomic) GBSearchViewMode mode;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *sortTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *filterTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *creatGanbareButton;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
- (IBAction)showFilterTypeView:(id)sender;
- (IBAction)showSortTypeView:(id)sender;
- (IBAction)searchButtonClicked:(id)sender;
- (IBAction)creatNewGanbareClicked:(id)sender;

@end
