//
//  GBBaseViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseViewController.h"
#import "GBWebViewController.h"

@implementation GBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
# pragma mark - key board
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hiddenKeyboard];
}

- (void)hiddenKeyboard {
    [self.view endEditing: YES];
}
#pragma mark - request

- (void)setLoading:(BOOL)loading {
    _loading = loading ;
    if (_loading) {
        if (!_spinner) {
            _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            _spinner.center = self.view.center; // I do this because I'm in landscape mode
            [self.view addSubview:_spinner];
        }
        [_spinner startAnimating];

    } else {
        [_spinner stopAnimating];
    }
}

#pragma mark - action
- (void)changeRootToMainMenu {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *mainMenuNavigationViewController = [storyboard instantiateViewControllerWithIdentifier:@"GBNavigationMainMenuViewController"];
    [[UIApplication sharedApplication] keyWindow].rootViewController = mainMenuNavigationViewController;
    [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
}

- (void)showGanbareIntroWebView {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    GBWebViewController *webViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"GBWebViewController"];
    webViewController.title = NSLocalizedString(@"利用規約", nil);
//    webViewController.stringURL = [NSString stringFromConst:qkCSUrlWebAgreement];
    [self.navigationController pushViewController:webViewController animated:YES];

}

- (void)goBack:(id)sender
{
    if (self.presentingViewController
        && [[self.navigationController.viewControllers firstObject] isEqual:self]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setupGanbareTotalStatusView {
    self.ganbareTotalStatusView.ganbareTotalNumber.text = [NSString stringWithFormat:@""];
}

@end
