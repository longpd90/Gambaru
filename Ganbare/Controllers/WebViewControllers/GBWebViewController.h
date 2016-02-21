//
//  GBWebViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/8/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseViewController.h"

@interface GBWebViewController : GBBaseViewController
@property (weak, nonatomic) IBOutlet UIWebView *webViewController;
@property (strong, nonatomic) NSString *stringURL;

@end
