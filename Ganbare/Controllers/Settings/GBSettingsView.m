//
//  GBSettingsView.m
//  Ganbare
//
//  Created by Phung Long on 9/25/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBSettingsView.h"


@implementation GBSettingsView

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.overlayView addGestureRecognizer:singleFingerTap];
    
    //The event handling method

}

#pragma mark - Table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kSectionsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == kInformations) {
        return kInformationsCount;
    } else if (section == kSettings) {
        return kSettingsCount;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ProfileCellIdentifier = @"GBSettingsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProfileCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ProfileCellIdentifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.textLabel.font = [UIFont fontWithName:PDGlobalNormalFontName size:17];
    
    if (indexPath.section == kInformations && indexPath.row == kGanbareIntroRow) {
        cell.textLabel.text = NSLocalizedString(@"ガンバレとは？", nil);
        
    } else if (indexPath.section == kInformations && indexPath.row == kWebSiteRow) {
        cell.textLabel.text = NSLocalizedString(@"サイト利用法", nil);
        
    } else if (indexPath.section == kInformations && indexPath.row == kNotificationRow) {
        cell.textLabel.text = NSLocalizedString(@"お知らせ", nil);
        
    } else if (indexPath.section == kInformations && indexPath.row == kPrivacyPolicyRow) {
        cell.textLabel.text = NSLocalizedString(@"プライバツーポリシー", nil);
        
    } else if (indexPath.section == kInformations && indexPath.row == kCompanyRow) {
        cell.textLabel.text = NSLocalizedString(@"運営会社", nil);
        
    } else if (indexPath.section == kInformations && indexPath.row == kQuestionRow) {
        cell.textLabel.text = NSLocalizedString(@"よくある質問", nil);
        
    }else if (indexPath.section == kInformations && indexPath.row == kContactUsRow) {
        cell.textLabel.text = NSLocalizedString(@"お問い合わせ", nil);
        
    } else if (indexPath.section == kSettings && indexPath.row == kChangeUserInfoRow) {
        cell.textLabel.text = NSLocalizedString(@"ユーザー陽報変更", nil);
        
    } else if (indexPath.section == kSettings && indexPath.row == kNotificationSettingsRow) {
        cell.textLabel.text = NSLocalizedString(@"通知設定", nil);
    }else if (indexPath.section == kSettings && indexPath.row == kScurityLanguageSettingsRow) {
        cell.textLabel.text = NSLocalizedString(@"セキュリティ。言語設定", nil);
    }else if (indexPath.section == kSettings && indexPath.row == kSNSSettingsRow) {
        cell.textLabel.text = NSLocalizedString(@"SNS設定", nil);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedIndexPath:)]) {
        [self.delegate didSelectedIndexPath:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == kInformations) {
        return NSLocalizedString(@"陽報", nil);
    } else if (section == kSettings) {
        return NSLocalizedString(@"設定", nil);
    }
    return nil;
}

#pragma mark - action

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {    
    if (self.delegate && [self.delegate respondsToSelector:@selector(overlayViewTouched)]) {
        [self.delegate overlayViewTouched];
    }
}

- (IBAction)signoutButtonclicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(signoutDelegate)]) {
        [self.delegate signoutDelegate];
    }
}

@end
