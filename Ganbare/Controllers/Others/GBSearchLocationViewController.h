//
//  GBSearchLocationViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/22/15.
//  Copyright © 2015 Phung Long. All rights reserved.
//

#import "GBBaseTableViewController.h"
#import <MapKit/MapKit.h>
#import "GBGanbareEntity.h"

@interface GBSearchLocationViewController : GBBaseTableViewController
@property (weak, nonatomic) GBGanbareEntity *ganbare;
@property (weak, nonatomic) IBOutlet UITextField *searchLocationTextField;
- (IBAction)cancelButtonClicked:(id)sender;
- (IBAction)textfieldDidChange:(id)sender;

@end
