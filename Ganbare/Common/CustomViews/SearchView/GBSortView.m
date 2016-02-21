//
//  GBSortView.m
//  Ganbare
//
//  Created by Phung Long on 9/10/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBSortView.h"

@implementation GBSortView


- (void)setSortTiles:(NSArray *)sortTiles {
    _sortTiles = sortTiles;
    self.height = sortTiles.count * 40;
    [self.sortTablewView reloadData];
}

#pragma mark - private

- (void)show {
//    [self.pickerView selectRow:_selectedIndex inComponent:0 animated:NO];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    self.frame = CGRectMake(0, -self.height, 320, self.height);
    self.hidden = YES;
    [keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, 0, 320, self.height);
    } completion:^(BOOL finished) {
        
    }];
}

# pragma mark - Tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sortTiles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"GBSortTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [_sortTiles objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectSortTile:)]) {
        [self.delegate didSelectSortTile:indexPath.row];
    }
}


@end
