//
//  GBWebImage.m
//  Ganbare
//
//  Created by Phung Long on 9/14/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBWebImage.h"
#import "UIImageView+AFNetworking.h"

@interface GBWebImage ()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation GBWebImage

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview:_activityIndicator];
}

- (void)setImageWithQKURL:(NSURL *)url withCache:(BOOL)isCache {
    [self setImageWithQKURL:url placeholderImage:nil withCache:isCache];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _activityIndicator.center = self.centerOfView;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}


- (void)setImageWithQKURL:(NSURL *)url
         placeholderImage:(UIImage *)placeholderImage withCache:(BOOL)isCache {
    //show loading

    [_activityIndicator startAnimating];
    _activityIndicator.hidden = NO;

    NSMutableURLRequest *imageRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    if (!isCache) {
        imageRequest.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    }
    [imageRequest addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    //get image from url
    __weak typeof(self) weakSelf = self;
    
    [self setImageWithURLRequest:imageRequest placeholderImage:placeholderImage success: ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [weakSelf.activityIndicator stopAnimating];
        weakSelf.activityIndicator.hidden = YES;
        [weakSelf setImage:image];
        [weakSelf setNeedsLayout];
        
    } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [weakSelf.activityIndicator stopAnimating];
        weakSelf.activityIndicator.hidden = YES;
    }];
}

- (void)setImageWithImageURL:(NSURL *)url
         placeholderImage:(UIImage *)placeholderImage
                   withCache:(BOOL)isCache
success: (void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
failure: (void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure{
    //show loading
    
    [_activityIndicator startAnimating];
    _activityIndicator.hidden = NO;
    
    NSMutableURLRequest *imageRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    if (!isCache) {
        imageRequest.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    }
    [imageRequest addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    //get image from url
    __weak typeof(self) weakSelf = self;
    
    [self setImageWithURLRequest:imageRequest placeholderImage:placeholderImage success: ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        success(request,response,image);
        [weakSelf.activityIndicator stopAnimating];
        weakSelf.activityIndicator.hidden = YES;
    } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        failure(request,response,error);
        [weakSelf.activityIndicator stopAnimating];
        weakSelf.activityIndicator.hidden = YES;
    }];
}

@end
