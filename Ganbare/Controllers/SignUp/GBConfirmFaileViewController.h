//
//  GBConfirmFaileViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/9/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseViewController.h"
#import "GBGanbareToolBarView.h"

@interface GBConfirmFaileViewController : GBBaseViewController
@property (weak, nonatomic) IBOutlet GBGanbareToolBarView *ganbareToolbarView;
- (IBAction)checkConfirmButtonClicked:(id)sender;

@end
