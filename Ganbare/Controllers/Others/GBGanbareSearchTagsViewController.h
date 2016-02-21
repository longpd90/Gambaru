//
//  GBGanbareSearchTagsViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/29/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseTableViewController.h"
#import "GBGanbareEntity.h"

@interface GBGanbareSearchTagsViewController : GBBaseTableViewController

@property (weak, nonatomic) GBGanbareEntity *ganbare;
@property (strong, nonatomic) NSMutableArray *tags;

@property (weak, nonatomic) IBOutlet UIView *tagsView;
@property (weak, nonatomic) IBOutlet UITextField *searchTagTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeightContraint;
- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)textfieldDidChange:(id)sender;
- (IBAction)creatNewTag:(id)sender;

@end
