//
//  GBCropImageViewController.m
//  Ganbare
//
//  Created by Phung Long on 9/21/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBCropImageViewController.h"
#define CropViewWidth 290.0
@interface GBCropImageViewController ()<UIScrollViewDelegate>

@end
@implementation GBCropImageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupInterface];
}

- (void)viewDidUnload {
    self.scrollView = nil;
    self.imageView = nil;
}

#pragma mark - interface
- (void)initViews {
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.topView.userInteractionEnabled = NO;
    self.rightView = [[UIView alloc] init];
    self.rightView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.leftView = [[UIView alloc] init];
    self.leftView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    self.bottomView.userInteractionEnabled = NO;
    self.leftView.userInteractionEnabled = NO;
    self.rightView.userInteractionEnabled = NO;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.rightView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.leftView];
    CGFloat witdh = [[UIApplication sharedApplication] keyWindow].width;
    [self updateRectanglePathAtLocation:CGPointMake(self.view.width / 2.0, self.view.height / 2.0 + 32.0) radius:self.view.bounds.size.width * CropViewWidth / witdh];
}

- (void)updateRectanglePathAtLocation:(CGPoint)location radius:(CGFloat)radius {
    self.rectangleCenter = location;
    self.rectangleRadius = radius;
    float width = self.view.width;
    float maxY = self.view.height - CGRectGetHeight(self.frame) - 50.0;
    
    if (self.cropImageType == GBCropImageTypeRectangle) {
        self.frame = CGRectMake(self.rectangleCenter.x - self.rectangleRadius / 2, self.rectangleCenter.y - self.rectangleRadius / 3, self.rectangleRadius, 130);
    }
    else {
        self.frame = CGRectMake(self.rectangleCenter.x - self.rectangleRadius / 2, self.rectangleCenter.y - self.rectangleRadius / 2, self.rectangleRadius, self.rectangleRadius);
    }
    
    if (self.rectangleCenter.x - self.rectangleRadius / 2 < -1) {
        CGRect frame = self.frame;
        frame.origin.x = 0;
        self.frame = frame;
    }
    
    if (CGRectGetMaxX(self.frame) > width) {
        CGRect frame = self.frame;
        frame.origin.x = width - CGRectGetWidth(self.frame);
        self.frame = frame;
    }
    
    if (CGRectGetMinY(self.frame) < 64) {
        CGRect frame = self.frame;
        frame.origin.y = 64;
        self.frame = frame;
    }
    
    if (CGRectGetMaxY(self.frame) > self.view.frame.size.height - 50.0) {
        CGRect frame = self.frame;
        frame.origin.y = maxY;
        self.frame = frame;
    }
    CGRect frame = self.frame;
    frame.origin.x -= 1.0;
    frame.origin.y -= 2.0;
    frame.size.width += 2.0;
    frame.size.height += 4.0;
    self.cropView = [[UIView alloc] initWithFrame:frame];
    self.cropView.backgroundColor = [UIColor clearColor];
    self.cropView.layer.borderWidth = 2.0;
    self.cropView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.cropView.userInteractionEnabled = NO;
    [self.view addSubview:self.cropView];
    
    
    self.topView.frame = CGRectMake(0, 64.0, width, CGRectGetMinY(self.frame) - 64.0);
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.frame), width, CGRectGetMaxY(self.view.frame) - CGRectGetMaxY(self.frame));
    self.leftView.frame = CGRectMake(0, CGRectGetMinY(self.frame), CGRectGetMinX(self.frame), CGRectGetHeight(self.frame));
    self.rightView.frame = CGRectMake(CGRectGetMaxX(self.frame), CGRectGetMinY(self.frame), width - CGRectGetMaxX(self.frame), CGRectGetHeight(self.frame));
}

- (void)setupInterface {
    self.scrollView.scrollsToTop = NO;
    self.scrollView.bouncesZoom = YES;
    self.scrollView.clipsToBounds = YES;
    
    //Setting up the imageView
    float scale = self.sourceImage.size.width / CGRectGetWidth(self.scrollView.frame);
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, self.sourceImage.size.height / scale)];
    self.imageView.image = self.sourceImage;
    self.imageView.backgroundColor = [UIColor grayColor];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    CGFloat witdh = [[UIApplication sharedApplication] keyWindow].frame.size.width;
    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = CropViewWidth / witdh;//This is the minimum scale, set it to whatever you want. 1.0 = default
    self.scrollView.maximumZoomScale = 4.0;
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.zoomScale = minimumScale;
    [self.scrollView setContentSize:CGSizeMake(self.imageView.frame.size.width, self.imageView.frame.size.height)];
    [self setContentInsetForScrollView];
}

- (void)setContentInsetForScrollView {
    float vSpace = CGRectGetHeight(self.topView.frame);
    [self.scrollView setContentInset:UIEdgeInsetsMake(2 * vSpace, 2 * vSpace, 4 * vSpace, 2 * vSpace)];
    [self.scrollView setContentOffset:CGPointZero];
}

#pragma mark - public
- (void)setSourceImage:(UIImage *)sourceImage {
    _sourceImage = sourceImage;
}
- (void)setCropImageType:(GBCropImageType)cropImageType {
    _cropImageType = cropImageType;
}

#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)aScrollView {
    CGFloat offsetX = (self.scrollView.frame.size.width > self.scrollView.contentSize.width) ?
    (self.scrollView.frame.size.width - self.scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (self.scrollView.frame.size.height > self.scrollView.contentSize.height) ?
    (self.scrollView.frame.size.height - self.scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(self.scrollView.contentSize.width * 0.5 + offsetX,
                                        self.scrollView.contentSize.height * 0.5 + offsetY);
    if (!(offsetX == 0.0 && offsetY == 0.0)) {
        [self.scrollView setContentOffset:CGPointZero];
    }
}

#pragma mark - IBAction

- (IBAction)cancelCropImage:(id)sender {
    [self dismissViewControllerAnimated:YES completion: ^{
    }];}

- (IBAction)cropImage:(id)sender {
    UIGraphicsBeginImageContext(self.view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect newFrame = self.frame;
    newFrame.origin.x = newFrame.origin.x + 1;
    newFrame.size.width = newFrame.size.width - 2;
    UIImage *croppedImage = [self image:img cropInRect:newFrame];
    self.croppedImage = croppedImage;
    //self.croppedImage = [self imageWithImage:self.sourceImage scaledToSize:CGSizeMake(1080.0f, 1920.0f)];
    //upload
    
    [self dismissViewControllerAnimated:YES completion: ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(croppedImage:imageId:)]) {
            [self.delegate croppedImage:self.croppedImage imageId:@""];
        }
    }];
}

- (UIImage *)image:(UIImage *)image cropInRect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

- (UIImage *)imageWithImage:(UIImage *)image
               scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
