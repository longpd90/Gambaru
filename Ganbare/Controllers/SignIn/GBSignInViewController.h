//
//  GBSignInViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/9/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseViewController.h"
#import "GBGlobalGrayTextField.h"

@interface GBSignInViewController : GBBaseViewController
@property (weak, nonatomic) IBOutlet GBGlobalGrayTextField *mailAddressTextField;
@property (weak, nonatomic) IBOutlet GBGlobalGrayTextField *passWordTextField;
@property (weak, nonatomic) IBOutlet GBDynamicLabel *totalGanbareLabel;
@property (strong, nonatomic) IBOutletCollection(GBGlobalGrayTextField) NSArray *textFieldCollection;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
- (IBAction)ganbareButtonClicked:(id)sender;
- (IBAction)signinButtonClicked:(id)sender;
- (IBAction)textFieldDidChangedText:(id)sender;

@end
