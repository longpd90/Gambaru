//
//  GBCropImageViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/21/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseViewController.h"


@protocol GBCropImageViewControllerDelegate <NSObject>

- (void)croppedImage:(UIImage *)image imageId:(NSString *)imageId;
@end


@interface GBCropImageViewController : GBBaseViewController

@property (weak, nonatomic) id <GBCropImageViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)  UIImageView *imageView;

@property (nonatomic) CGFloat rectangleRadius;
@property (nonatomic) CGPoint rectangleCenter;
@property (nonatomic, weak) CAShapeLayer *maskLayer;
@property (nonatomic, weak) CAShapeLayer *rectangleLayer;
@property (nonatomic) CGRect frame;
@property (nonatomic) CGFloat lastZoomScale;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *rightView;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *cropView;

//param

@property (strong, nonatomic) UIImage *sourceImage;
@property (strong, nonatomic) UIImage *croppedImage;
@property (assign, nonatomic) GBCropImageType cropImageType;


@end
