//
//  GBRequestManager.h
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"

@interface GBRequestManager : AFHTTPRequestOperationManager
@property (strong, nonatomic) NSString *totalGanbareNumber;
+ (GBRequestManager *)sharedManager;
- (void)setToken:(NSString *)tokenString;

// asys request
- (AFHTTPRequestOperation *)asyncGET:(NSString *)URLString
                          parameters:(id)parameters
                   isShowLoadingView:(BOOL)isShowLoadingView
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure ;
- (AFHTTPRequestOperation *)asyncDELETE:(NSString *)URLString
                             parameters:(id)parameters
                      isShowLoadingView:(BOOL)isShowLoadingView
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure  ;

- ( AFHTTPRequestOperation *)asyncPUT:(NSString *)URLString
                           parameters:(id)parameters
                    isShowLoadingView:(BOOL)isShowLoadingView
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure ;
- ( AFHTTPRequestOperation *)asyncPOST:(NSString *)URLString
                            parameters:(id)parameters
                     isShowLoadingView:(BOOL)isShowLoadingView
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)asyncPOSTData:(NSString *)URLString
                               parameters:(id)parameters
                        isShowLoadingView:(BOOL)isShowLoadingView
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formdata))block
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure ;

//sys request
- ( AFHTTPRequestOperation *)syncPOST:(NSString *)URLString
                           parameters:(id)parameters
                    isShowLoadingView:(BOOL)isShowLoadingView
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)syncGET:(NSString *)URLString
                         parameters:(NSDictionary *)parameters
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- ( AFHTTPRequestOperation *)syncPUT:(NSString *)URLString
                          parameters:(id)parameters
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
