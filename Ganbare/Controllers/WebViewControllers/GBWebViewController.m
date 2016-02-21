//
//  GBWebViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/8/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBWebViewController.h"

@interface GBWebViewController ()

@end

@implementation GBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *url = @"http://yahoo.jp";
    if (_stringURL) {
        url = _stringURL;
    }
    [self.webViewController loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
