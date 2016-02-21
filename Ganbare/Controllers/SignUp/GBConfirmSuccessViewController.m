//
//  GBConfirmSuccessViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/9/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBConfirmSuccessViewController.h"

@interface GBConfirmSuccessViewController ()

@end

@implementation GBConfirmSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ganbareToolbarView setSignupInterface];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)mypageButtonClicked:(id)sender {
    [self changeRootToMainMenu];
}

- (IBAction)introButtonClicked:(id)sender {
}
@end
