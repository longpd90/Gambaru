//
//  GBWebImage.h
//  Ganbare
//
//  Created by Phung Long on 9/14/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBWebImage : UIImageView

- (void)setImageWithQKURL:(NSURL *)url withCache:(BOOL)isCache;
- (void)setImageWithQKURL:(NSURL *)url
         placeholderImage:(UIImage *)placeholderImage withCache:(BOOL)isCache;
- (void)setImageWithImageURL:(NSURL *)url
            placeholderImage:(UIImage *)placeholderImage
                   withCache:(BOOL)isCache
                     success: (void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                     failure: (void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;
@end
