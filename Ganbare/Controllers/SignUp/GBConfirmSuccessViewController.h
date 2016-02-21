//
//  GBConfirmSuccessViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/9/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseViewController.h"
#import "GBGanbareToolBarView.h"

@interface GBConfirmSuccessViewController : GBBaseViewController
- (IBAction)mypageButtonClicked:(id)sender;
- (IBAction)introButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet GBGanbareToolBarView *ganbareToolbarView;

@end
