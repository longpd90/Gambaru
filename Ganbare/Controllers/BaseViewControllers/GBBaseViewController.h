//
//  GBBaseViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBGanbareStatusView.h"

@interface GBBaseViewController : UIViewController

@property (strong, nonatomic) IBOutlet GBGanbareStatusView *ganbareTotalStatusView;
@property (assign, nonatomic) BOOL loading;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
- (void)changeRootToMainMenu;
- (void)goBack:(id)sender;
- (void)hiddenKeyboard;
@end
