//
//  GBGlobalDatePicker.h
//  Ganbare
//
//  Created by Phung Long on 9/18/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBGlobalDatePicker;
@protocol GBGlobalDatePickerDelegate <NSObject>
- (void)pickedDatePicker:(GBGlobalDatePicker *)datePicker withDate:(NSDate *)date;
@optional
- (void)cancelDatePicker:(GBGlobalDatePicker *)datePicker;
@end

@interface GBGlobalDatePicker : UIView
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (weak, nonatomic) id <GBGlobalDatePickerDelegate> delegate;

- (void)show;

@end

