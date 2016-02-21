//
//  GBGlobalPickerView.h
//  Ganbare
//
//  Created by Phung Long on 10/12/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GBGlobalPickerView;

@protocol GBGlobalPickerViewDelegate <NSObject>
- (void)donePickerView:(GBGlobalPickerView *)pickerView selectedIndex:(NSInteger)selectedIndex;
@optional
-(void)cancelPickerView:(GBGlobalPickerView*)pickerView;
@end

@interface GBGlobalPickerView : UIView
@property (weak, nonatomic) id <GBGlobalPickerViewDelegate> delegate;

@property (nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIToolbar *toolBar;

- (void)show;

- (void) reloadPicker;

@end
