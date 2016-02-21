//
//  GBGanbareDetailViiew.m
//  Ganbare
//
//  Created by Phung Long on 9/15/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBGanbareDetailView.h"
#import "GBGanbareCommentView.h"

#define MaxGanbareContentLabelHeight 90.0
@interface GBGanbareDetailView ()
@property (assign, nonatomic) long int ganbareNumberShowing;
@property (assign, nonatomic) BOOL commentViewIsShowing;

@end

@implementation GBGanbareDetailView

- (id)init {
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];
}

- (void)initialization {
    [self.likeButton setImage:[UIImage imageNamed:@"like-user-icon"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"unlike-user-icon"] forState:UIControlStateSelected];

    [self.likeButton setBackgroundImage:[UIButton imageFromColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [self.likeButton setBackgroundImage:[UIButton imageFromColor:[UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:1]] forState:UIControlStateSelected];

    [self.pinGanbareButton setImage:[UIImage imageNamed:@"pin-ganbare-icon"] forState:UIControlStateNormal];
    [self.pinGanbareButton setImage:[UIImage imageNamed:@"unpin-ganbare-icon"] forState:UIControlStateSelected];
    [self.pinGanbareButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.pinGanbareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    self.commentView.clipsToBounds = YES;
    _commentViewIsShowing = YES;
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.overlayView addGestureRecognizer:singleFingerTap];
    self.extraButton.layer.borderColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1].CGColor;
    self.extraButton.layer.borderWidth = 2;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(itemWasChanged:)
                                                 name:kGBItemWasChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wasAddedGanbare:)
                                                 name:kGBWasAddedGanbareNotification
                                               object:nil];
    

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGBItemWasChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kGBWasAddedGanbareNotification object:nil];

}


- (void)layoutSubviews {
//    [super layoutSubviews];
    self.frame = [[UIApplication sharedApplication] keyWindow].frame ;
    self.ganbareView.center = self.center;
}

#pragma mark - setup

- (void)setGanbareID:(NSString *)ganbareID {
    _ganbareID = ganbareID;
    [self getGanbareDetail:ganbareID];
}

- (void)setGanbareModel:(GBGanbareEntity *)ganbareModel {
    _ganbareModel = ganbareModel;
    _creatDateLabel.text = [NSString stringWithFormat:@"%@",[ ganbareModel.createDate stringValueFormattedBy:@"yy/MM/dd/HH:mm"]];
    _expiringDateLabel.text = [NSString stringWithFormat:@"%@",[ ganbareModel.expiredDate stringValueFormattedBy:@"yy/MM/dd/HH:mm"]];

    self.usernameLabel.text = ganbareModel.user.userName;
    self.loginIDLabel.text = _ganbareModel.user.loginId;
    self.gabareNumberLabel.text = [NSString stringWithFormat:@"%@",[[GBAlgorithm sharedAlgorithm] numberWithCommas:_ganbareModel.ganbareNumber integerDigits:24]];
    
    self.ganbareContentTextView.text = ganbareModel.ganbaruContent;
    CGSize maximumLabelSize = CGSizeMake(self.frame.size.width,MAXFLOAT);
    NSDictionary *attributes = @{ NSFontAttributeName:[ self.ganbareContentTextView font]};
    CGSize expectedLabelSize = [ self.ganbareContentTextView.text boundingRectWithSize:maximumLabelSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    
    float expectHeight = expectedLabelSize.height;
    
    if (expectHeight >= MaxGanbareContentLabelHeight) {
        expectHeight = MaxGanbareContentLabelHeight;
    }
    self.textViewHeightConstraint.constant = expectHeight;

    long int ganbareNumberShow = MIN(kMaxGanbareNumberInView, ganbareModel.ganbareNumber);
    for (int i = 0; i < ganbareNumberShow; i ++) {
        [self addGanbareCommentToview];
    }
    if ([_ganbareModel.user.identifier isEqualToString:kGBUserID]) {
        self.likeButton.hidden = YES;
        self.pinGanbareButton.hidden = YES;
        self.editGanbareButton.hidden = NO;

    } else {
        self.editGanbareButton.hidden = YES;
        self.likeButton.hidden = NO;
        self.pinGanbareButton.hidden = NO;
    }
    self.likeButton.selected = _ganbareModel.user.favoristUser;
    self.pinGanbareButton.selected = _ganbareModel.pinning;
    [self.userAvatarImageView setImageWithQKURL:_ganbareModel.user.avatarURL placeholderImage:nil withCache:YES];
    [self.ganbareImageView setImageWithQKURL:_ganbareModel.ganbareImageURL placeholderImage:nil withCache:YES];
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

#pragma mark - call api

- (void)getGanbareDetail:(NSString *)ganbareID{
    [[GBRequestManager sharedManager] asyncGET:[NSString stringWithFormat:@"%@%@",gbURLGanbare,ganbareID] parameters:nil isShowLoadingView:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            GBGanbareEntity *ganbare = [[GBGanbareEntity alloc] initWithDictionary:[responseObject objectForKey:@"data"]];
            self.ganbareModel = ganbare;
            NSLog(@"response :%@",responseObject);
        } else {
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


#pragma mark - notification

- (void)itemWasChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    GBItem *object = [userInfo objectForKey:@"object"];
    if ([object isKindOfClass:[GBGanbareEntity class]]) {
        if ([self.ganbareModel.identifier isEqualToString:object.identifier]) {
            [self.ganbareModel setValuesFromArray:userInfo[@"values"]];
            self.pinGanbareButton.selected = _ganbareModel.pinning;
            self.gabareNumberLabel.text =[NSString stringWithFormat:@"%@",[[GBAlgorithm sharedAlgorithm] numberWithCommas:_ganbareModel.ganbareNumber integerDigits:24]];
        }
    }
    if ([object isKindOfClass:[GBUserEntity class]]) {
        if ([self.ganbareModel.user.identifier isEqualToString:object.identifier]) {
            [self.ganbareModel.user setValuesFromArray:userInfo[@"values"]];
            self.likeButton.selected = _ganbareModel.user.favoristUser;
        }
    }
    
}

- (void)wasAddedGanbare:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    GBItem *object = [userInfo objectForKey:@"object"];
    if ([object isKindOfClass:[GBGanbareEntity class]]) {
        if ([self.ganbareModel.identifier isEqualToString:object.identifier]) {
            [self.ganbareModel setValuesFromArray:userInfo[@"values"]];
            self.gabareNumberLabel.text =[NSString stringWithFormat:@"%@",[[GBAlgorithm sharedAlgorithm] numberWithCommas:_ganbareModel.ganbareNumber integerDigits:24]];
            [self addGanbareCommentToview];
        }
    }
}

#pragma mark - action

- (IBAction)ganbareButtonClicked:(id)sender {
    [self.ganbareModel ganbareAction];
}

- (IBAction)editButtonClicked:(id)sender {
    [self hidden];
    if (self.delegate && [self.delegate respondsToSelector:@selector(editGanbare:)]) {
        [self.delegate editGanbare:_ganbareModel];
    }
}

- (IBAction)extraButtonClicked:(id)sender {
}

- (IBAction)likeButtonClicked:(id)sender {
    if (self.likeButton.selected) {
        [self.ganbareModel.user removeUserFromFavorite];
    } else {
        [self.ganbareModel.user addUserToFavorite];
    }
}

- (IBAction)pinButtonClicked:(id)sender {
    if (self.pinGanbareButton.selected) {
        [self.ganbareModel unpinGanbare];
    } else {
        [self.ganbareModel pinGanbare];
    }
}

- (IBAction)hiddenComment:(id)sender {
    if (_commentViewIsShowing) {
        self.ganbareButton.enabled = NO;

        self.ganbareContentTextView.hidden = YES;
        self.backgroundGanbareContentView.hidden = YES;
        NSArray *viewsToRemove = [self.commentView subviews];
        for (UIView *v in viewsToRemove) {
            v.hidden = YES;
        }
    } else {
        self.ganbareButton.enabled = YES;

        self.ganbareContentTextView.hidden = NO;
        self.backgroundGanbareContentView.hidden = NO;
        NSArray *viewsToRemove = [self.commentView subviews];
        for (UIView *v in viewsToRemove) {
            v.hidden = NO;
        }
    }
    _commentViewIsShowing =! _commentViewIsShowing;
}

- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];

    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations: ^{
        self.alpha = 1;
    }];
}

- (void)hidden {
    [self removeFromSuperview];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self hidden];;
}

@end
