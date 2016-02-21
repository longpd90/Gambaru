//
//  GBGanbareSearchTagsViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/29/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGanbareSearchTagsViewController.h"
#import "GBTagView.h"

@interface GBGanbareSearchTagsViewController ()<GBTagViewDelegate>

@property (strong, nonatomic) NSString *tagsSearch;
@end

@implementation GBGanbareSearchTagsViewController

- (void)viewDidLoad {
    _tagsSearch = @"";
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.tags.count > 0) {
        [self refreshTagsView];
    }
}
- (void)setGanbare:(GBGanbareEntity *)ganbare {
    _ganbare = ganbare;
    self.tags = [NSMutableArray arrayWithArray:_ganbare.ganbaruTags] ;
}

- (void)refetchData {
    _tagsSearch = _searchTagTextField.text;
    [super refetchData];
}
#pragma mark - call api

- (void)getData {
    [super getData];
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:_tagsSearch forKey:@"tagName"];
    [[GBRequestManager sharedManager] asyncGET:[NSString stringFromConst:gbURLSearchTags] parameters:params isShowLoadingView:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSArray *tagsName = [responseObject objectForKey:@"data"];
            for (NSString *tagName in tagsName) {
                [self.items addObject:tagName];
            }
        }
        [self refreshView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error  %@",error);
        self.tableViewState = GBItemsTableViewStateNormal;
    }];
}

#pragma mark - tagView
- (void)refreshTagsView
{
    NSArray *viewsToRemove = [self.tagsView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    int startIndex = 0, endIndex = 0;
    float width = 0;
    int viewNumber = 0;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:GBGlobalNormalFontName size:14]};
    for (int i = 0; i < _tags.count; i++) {
        NSString *tag = _tags[i];
        
        int labelWidth = [tag sizeWithAttributes:attributes].width + 10;
        if (labelWidth >= kMaxWidthTagLabel) {
            labelWidth = kMaxWidthTagLabel;
        }
        width += labelWidth + 30;
        if (width >= self.tagsView.width) {
            endIndex = i ;
            [self addTagViewWithStartIndex:startIndex endIndex:endIndex originY:(viewNumber * 30.0) + 5];
            startIndex = endIndex ;
            viewNumber ++;
            width = [tag sizeWithAttributes:attributes].width + 40;
        }
        if (i == _tags.count - 1) {
            [self addTagViewWithStartIndex:startIndex endIndex:_tags.count originY:(viewNumber * 30.0 + 5)];
        }
    }
   _tagViewHeightContraint.constant = (viewNumber + 1) * 30.0 + 5;

}

- (void)addTagViewWithStartIndex:(int)startIndex endIndex:(NSInteger)endIndex originY:(float)y
{
    UIView *tagSubView = [[UIView alloc] initWithFrame:CGRectMake(0, y , 0, 30)];
    [self.tagsView addSubview:tagSubView];
    float x = 5;
    for (int i = startIndex; i < endIndex; i ++) {
        NSString *tag = _tags[i];
        GBTagView *tagView = [[GBTagView alloc] init];
        [tagSubView addSubview:tagView];
        tagView.index = i;
        tagView.delegate = self;
        tagView.tagName = tag;
        tagView.x = x;
        x = tagView.rightXPoint + 5;
    }
    tagSubView.width = x;
}

- (void)removeTagsWithIndex:(NSInteger)index {
    
    [_tags removeObjectAtIndex:index];
    [self refreshTagsView];
}

#pragma mark - action

- (IBAction)cancelButtonClicked:(id)sender {
    _ganbare.ganbaruTags = _tags;
    [self goBack:sender];
}

- (IBAction)textfieldDidChange:(id)sender {
    [self refetchData];
}

- (IBAction)creatNewTag:(id)sender {
    [self hiddenKeyboard];
    if (_searchTagTextField.text.length <= 0) {
        return;
    }
    NSString *tagName = _searchTagTextField.text;
    [_tags addObject:tagName];
    [self refreshTagsView];
    _searchTagTextField.text = nil;
    [self refetchData];
    
}

# pragma mark - Tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"GBSearchTagsTableViewCell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        // Remove seperator inset
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        // Prevent the cell from inheriting the Table View's margin settings
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        
        // Explictly set your cell's layout margins
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    NSString *tagName = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text =  tagName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hiddenKeyboard];
    NSString *tagName = [self.items objectAtIndex:indexPath.row];
    [_tags addObject:tagName];
    [self refreshTagsView];
    _searchTagTextField.text = nil;
    [self refetchData];
    
}



@end
