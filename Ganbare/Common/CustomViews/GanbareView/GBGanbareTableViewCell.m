//
//  GBGanbareTableViewCell.m
//  Ganbare
//
//  Created by Phung Long on 9/7/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGanbareTableViewCell.h"
#import <stdlib.h>
#import "GBGanbareCommentView.h"

#define MaxGanbareContentLabelHeight 80.0
#define MaxUserNameLabelHeight 32.0


@interface GBGanbareTableViewCell ()
@property (assign, nonatomic) long int ganbareNumberShowing;
@end

@implementation GBGanbareTableViewCell

- (void)awakeFromNib {
    [self.likeUserButton setImage:[UIImage imageNamed:@"favorite-user-icon"] forState:UIControlStateNormal];
    [self.likeUserButton setImage:[UIImage imageNamed:@"unlike-user-icon"] forState:UIControlStateSelected];
    [self.pinGanbareButton setImage:[UIImage imageNamed:@"pin-icon-gray"] forState:UIControlStateNormal];
    [self.pinGanbareButton setImage:[UIImage imageNamed:@"unpin-ganbare-icon"] forState:UIControlStateSelected];
    self.expiredDateLabel.adjustsFontSizeToFitWidth = YES;
    self.startDateLabel.adjustsFontSizeToFitWidth = YES;
    
    [self.pinGanbareButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.pinGanbareButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    self.commentView.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wasAddedGanbare:)
                                                 name:kGBWasAddedGanbareNotification
                                               object:nil];
    
    
    // Remove seperator inset
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [self setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGBWasAddedGanbareNotification object:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    if (_mode == GBGanbareTableViewCellModeNormal) {
        self.ganbareButtonRightConstraint.constant = 0;

    } else {
        self.ganbareButtonRightConstraint.constant = - self.centerOfView.x + self.ganbareContentView.x + self.ganbareButton.width/2.0 ;

    }
}
#pragma mark - setup
- (void)setGanbareModel:(GBGanbareEntity *)ganbareModel {
    _ganbareNumberShowing = 0;
    NSArray *viewsToRemove = [self.commentView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    _ganbareModel = ganbareModel;
    if (ganbareModel.createDate != nil) {
        self.startDateLabel.text = [NSString stringWithFormat:@"%@",[ ganbareModel.createDate stringValueFormattedBy:@"yy/MM/dd/HH:mm"]];
    }
    if (ganbareModel.expiredDate != nil) {
        self.expiredDateLabel.text = [NSString stringWithFormat:@"%@",[ganbareModel.expiredDate stringValueFormattedBy:@"yy/MM/dd/HH:mm"]];
    }
    
    self.usernameLabel.text = ganbareModel.user.userName;
    [self.usernameLabel sizeToFit];
    self.ganbareNumberLabel.text = [NSString stringWithFormat:@"%@",[[GBAlgorithm sharedAlgorithm] numberWithCommas:_ganbareModel.ganbareNumber integerDigits:24]] ;
    
    long int ganbareNumberShow = MIN(kMaxGanbareNumberInView, ganbareModel.ganbareNumber);
    for (int i = 0; i < ganbareNumberShow; i ++) {
        [self addGanbareCommentToview];
    }
    
    self.ganbareContentTextView.text = ganbareModel.ganbaruContent;
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width,MAXFLOAT);
    NSDictionary *attributes = @{ NSFontAttributeName:[ self.ganbareContentTextView font]};
    CGSize expectedLabelSize = [ self.ganbareContentTextView.text boundingRectWithSize:maximumLabelSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    
    float expectHeight = expectedLabelSize.height;

    if (expectHeight >= MaxGanbareContentLabelHeight) {
        expectHeight = MaxGanbareContentLabelHeight;
    }
    self.textViewHeightConstraint.constant = expectHeight;

    self.likeUserButton.selected = _ganbareModel.user.favoristUser;
    self.pinGanbareButton.selected = _ganbareModel.pinning;
    
    if ([_ganbareModel.user.identifier isEqualToString:kGBUserID] ||
        [kGBUserID isEqualToString:@""] ||
        kGBUserID == nil) {
        self.mode = GBGanbareTableViewCellModeVisitor;
    } else {
        self.mode = GBGanbareTableViewCellModeNormal;
    }
    [self.userAvatarImageView setImageWithQKURL:ganbareModel.user.avatarURL placeholderImage:nil withCache:YES];
    [self.ganbareImageView setImageWithQKURL:ganbareModel.ganbareImageURL placeholderImage:nil withCache:YES];
}
- (void)setBackgroundEffect {
    self.ganbareBackgroundEffectImageView.hidden = NO;
}

- (void)setUserGanbareEffect {
    self.ganbareBackgroundEffectImageView.hidden = NO;
    self.yellowBackgroundImageview.hidden = NO;

}

- (void)setMode:(GBGanbareTableViewCellMode)mode {
    _mode = mode;
    if (_mode == GBGanbareTableViewCellModeNormal) {
        self.likeUserButton.hidden = NO;
        self.pinGanbareButton.hidden = NO;
    } else {
        self.likeUserButton.hidden = YES;
        self.pinGanbareButton.hidden = YES;
    }
}

- (void)addGanbareCommentToview {
    if (_ganbareNumberShowing == kMaxGanbareNumberInView) {
        return;
    }
    NSInteger mode = [self randomNumberBetween:0 maxNumber:2];
    GBGanbareCommentView *ganbareCommentView = [[GBGanbareCommentView alloc] initWithMode:mode];
    float centerX = [self randomFloatBetween:0 and:self.commentView.width];
    float centerY = [self randomFloatBetween:0 and:self.commentView.height];
    ganbareCommentView.center = CGPointMake(centerX, centerY);
    [self.commentView addSubview:ganbareCommentView];
    _ganbareNumberShowing += 1;
    
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

- (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return  min + arc4random() % (max - min);

}
#pragma mark - action

- (IBAction)likeUserButtonClicked:(id)sender {
    if (self.likeUserButton.selected) {
        [self.ganbareModel.user removeUserFromFavorite];
    } else {
        [self.ganbareModel.user addUserToFavorite];
    }
}

- (IBAction)pinGanbareButtonClicked:(id)sender {
    if (self.pinGanbareButton.selected) {
        [self.ganbareModel unpinGanbare];
    } else {
        [self.ganbareModel pinGanbare];
    }
}

- (IBAction)ganbareButtonClicked:(id)sender {
    if ([kGBUserID isEqualToString:@""] ||
        kGBUserID == nil) {
        return;
    }
    [self.ganbareModel ganbareAction];
}

#pragma mark - call notification
- (void)wasAddedGanbare:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    GBItem *object = [userInfo objectForKey:@"object"];
    if ([object isKindOfClass:[GBGanbareEntity class]]) {
        if ([self.ganbareModel.identifier isEqualToString:object.identifier]) {
            [self.ganbareModel setValuesFromArray:userInfo[@"values"]];
            self.ganbareNumberLabel.text =[NSString stringWithFormat:@"%@",[[GBAlgorithm sharedAlgorithm] numberWithCommas:_ganbareModel.ganbareNumber integerDigits:24]];
            [self addGanbareCommentToview];
        }
    }
}


@end
