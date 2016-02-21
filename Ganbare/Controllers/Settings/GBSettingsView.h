//
//  GBSettingsView.h
//  Ganbare
//
//  Created by Phung Long on 9/25/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBSettingsView;
@protocol GBSettingsViewDelegate <NSObject>

@optional
- (void)overlayViewTouched;
- (void)signoutDelegate;
- (void)didSelectedIndexPath:(NSIndexPath *)indexPath;

@end

@interface GBSettingsView : UIView
@property (assign, nonatomic) id<GBSettingsViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
- (IBAction)signoutButtonclicked:(id)sender;

@end
