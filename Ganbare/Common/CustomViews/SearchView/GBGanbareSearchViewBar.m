//
//  GBGanbarTopMenuView.m
//  Ganbare
//
//  Created by Phung Long on 9/7/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGanbareSearchViewBar.h"

@implementation GBGanbareSearchViewBar

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSBundle mainBundle] loadNibNamed:@"GBGanbareSearchViewBar" owner:self options:nil];
    [self addSubview:self.view];
}

- (IBAction)signupButtonClicked:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoSignup" object:nil];
}

- (IBAction)showFilterTypeView:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showFilterType)]) {
        [self.delegate showFilterType];
    }
}

- (IBAction)showSortTypeView:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showSortType)]) {
        [self.delegate showSortType];
    }
}

- (IBAction)searchButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showSearchView)]) {
        [self.delegate showSearchView];
    }
}

- (IBAction)creatNewGanbareClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(creatGanbare)]) {
        [self.delegate creatGanbare];
    }
}

- (void)setMode:(GBSearchViewMode)mode {
    _mode = mode;
    if (mode == GBSearchViewModeVisitor) {
        self.creatGanbareButton.hidden = YES;
    }
}
@end
