//
//  GBRequestManager.m
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBRequestManager.h"
#import "GBLoadingView.h"
#import "GBNoInternetView.h"

#define INTERNET_TIMEOUT 20

@interface GBRequestManager ()
@property (strong, nonatomic) GBLoadingView *indicator;
@property (strong, nonatomic)  UIAlertView *alertNetworkError;
- (BOOL)connected;
@end
@implementation GBRequestManager

+ (GBRequestManager *)sharedManager {
    static dispatch_once_t pred;
    static GBRequestManager *_sharedManager = nil;
    dispatch_once(&pred, ^{
        _sharedManager = [self manager];
        [_sharedManager.requestSerializer clearAuthorizationHeader];
        _sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedManager.responseSerializer =  [AFJSONResponseSerializer serializer];
        _sharedManager.requestSerializer.timeoutInterval = INTERNET_TIMEOUT;
        _sharedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", @"application/x-www-form-urlencoded", nil];
        [_sharedManager.requestSerializer setValue:kGBAuthToken forHTTPHeaderField:@"Authorization"];
        if (!_sharedManager.indicator) {
            _sharedManager.indicator = [[GBLoadingView alloc] initHUDView];
        }

    });
    return _sharedManager;
}

- (void)setToken:(NSString *)tokenString {
    [self.requestSerializer setValue:tokenString forHTTPHeaderField:@"Authorization"];
}

- (void)resendRequest {
    
}

#pragma mark - asys request
- (AFHTTPRequestOperation *)asyncGET:(NSString *)URLString
                          parameters:(id)parameters
                   isShowLoadingView:(BOOL)isShowLoadingView
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    if (!self.connected) {
        [self showAlertError];
        return nil;
    }
    if (isShowLoadingView) {
        [_indicator showIndicator];
    }
    return [self GET:URLString parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        [_indicator hideIndicator];
        NSLog(@"response object :%@",responseObject);
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"extendedInfor" ];
            _totalGanbareNumber = [result stringForKey:@"totalGanbareNumber"];
            [self pushGanbareTotalNotification];
        }
//        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_INVALID_TOKEN]] ) {
//            [self callAPILogin];
//        }
        success(operation, responseObject);
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [_indicator hideIndicator];
        failure(operation, error);
        NSLog(@"error :%@",error);
    }];
    
}

- (AFHTTPRequestOperation *)asyncDELETE:(NSString *)URLString
                             parameters:(id)parameters
                      isShowLoadingView:(BOOL)isShowLoadingView
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure  {
    if (isShowLoadingView) {
        [_indicator showIndicator];
    }
    return [self DELETE:URLString parameters:parameters success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"response object :%@",responseObject);
        [_indicator hideIndicator];
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"extendedInfor" ];
            if (result) {
                _totalGanbareNumber = [result stringForKey:@"totalGanbareNumber"];
                [self pushGanbareTotalNotification];
            }
            
        }
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [_indicator hideIndicator];
        failure(operation,error);
        NSLog(@"error :%@",error);
    }];
    
}


- ( AFHTTPRequestOperation *)asyncPOST:(NSString *)URLString
                            parameters:(id)parameters
                     isShowLoadingView:(BOOL)isShowLoadingView
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (isShowLoadingView) {
        [_indicator showIndicator];
    }
    NSError *errorDictionary;
    NSData *jsonData ;
    if (parameters!=nil) {
        jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&errorDictionary];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:INTERNET_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    [request setValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:kGBAuthToken forHTTPHeaderField:@"Authorization"];
    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * operation, id responseObject) {
        [_indicator hideIndicator];
        NSLog(@"response object :%@",responseObject);
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"extendedInfor" ];
            _totalGanbareNumber = [result stringForKey:@"totalGanbareNumber"];
            [self pushGanbareTotalNotification];
        }
        success(operation,responseObject);
        NSLog(@"response object :%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [_indicator hideIndicator];
        failure(operation,error);
        NSLog(@"error :%@",error);
    }];
    [op start];
    return op;
}

- ( AFHTTPRequestOperation *)asyncPUT:(NSString *)URLString
                           parameters:(id)parameters
                    isShowLoadingView:(BOOL)isShowLoadingView
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (isShowLoadingView) {
        [_indicator showIndicator];
    }
    NSError *errorDictionary;
    NSData *jsonData ;
    if (parameters!=nil) {
        jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&errorDictionary];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:INTERNET_TIMEOUT];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    [request setValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:kGBAuthToken forHTTPHeaderField:@"Authorization"];
    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * operation, id responseObject) {
        [_indicator hideIndicator];
        NSLog(@"response object :%@",responseObject);
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"extendedInfor" ];
            _totalGanbareNumber = [result stringForKey:@"totalGanbareNumber"];
            [self pushGanbareTotalNotification];
        }
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [_indicator hideIndicator];
        failure(operation,error);
        NSLog(@"error :%@",error);
    }];
    [op start];
    return op;
}

- (AFHTTPRequestOperation *)asyncPOSTData:(NSString *)URLString
                               parameters:(id)parameters
                        isShowLoadingView:(BOOL)isShowLoadingView
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formdata))block
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure  {
    if (isShowLoadingView) {
        [_indicator showIndicator];
    }
    return [self POST:URLString parameters:parameters constructingBodyWithBlock: ^(id < AFMultipartFormData > formData) {
        block(formData);
    } success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response object :%@",responseObject);
        [_indicator hideIndicator];
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"extendedInfor" ];
            _totalGanbareNumber = [result stringForKey:@"totalGanbareNumber"];
            [self pushGanbareTotalNotification];
        }
        success(operation, responseObject);
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [_indicator hideIndicator];
        failure(operation, error);
    }];
}

#pragma mark - sys request

- (AFHTTPRequestOperation *)synchronouslyPerformMethod:(NSString *)method
                                             URLString:(NSString *)URLString
                                            parameters:(NSDictionary *)parameters
                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    [_indicator showIndicator];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    
    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * operation, id responseObject) {
        [_indicator hideIndicator];
        NSLog(@"response object :%@",responseObject);
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"extendedInfor" ];
            _totalGanbareNumber = [result stringForKey:@"totalGanbareNumber"];
            [self pushGanbareTotalNotification];
        }
        success(operation,responseObject);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [_indicator hideIndicator];
        failure(operation,error);
        NSLog(@"error :%@",error);
    }];
    [op start];
    [op waitUntilFinished];
    return op;
}

- ( AFHTTPRequestOperation *)syncPOST:(NSString *)URLString
                           parameters:(id)parameters
                    isShowLoadingView:(BOOL)isShowLoadingView
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (isShowLoadingView) {
        [_indicator showIndicator];
    }
    NSError *errorDictionary;
    NSData *jsonData ;
    if (parameters!=nil) {
        jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&errorDictionary];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:INTERNET_TIMEOUT];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    [request setValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:kGBAuthToken forHTTPHeaderField:@"Authorization"];
    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * operation, id responseObject) {
        [_indicator hideIndicator];
        NSLog(@"response object :%@",responseObject);
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"extendedInfor" ];
            _totalGanbareNumber = [result stringForKey:@"totalGanbareNumber"];
            [self pushGanbareTotalNotification];
        }
        success(operation,responseObject);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [_indicator hideIndicator];
        failure(operation,error);
        NSLog(@"error :%@",error);
    }];
    [op start];
    [op waitUntilFinished];
    return op;
}

- ( AFHTTPRequestOperation *)syncPUT:(NSString *)URLString
                          parameters:(id)parameters
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    [_indicator showIndicator];
    NSError *errorDictionary;
    NSData *jsonData ;
    if (parameters!=nil) {
        jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&errorDictionary];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData  timeoutInterval:INTERNET_TIMEOUT];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody: jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"utf-8" forHTTPHeaderField:@"Accept-Charset"];
    [request setValue: @"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:kGBAuthToken forHTTPHeaderField:@"Authorization"];
    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * operation, id responseObject) {
        NSLog(@"response object :%@",responseObject);
        [_indicator hideIndicator];
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *result = [responseObject objectForKey:@"extendedInfor" ];
            _totalGanbareNumber = [result stringForKey:@"totalGanbareNumber"];
            [self pushGanbareTotalNotification];
        }
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        [_indicator hideIndicator];
        failure(operation,error);
        NSLog(@"error :%@",error);
    }];
    [op start];
    [op waitUntilFinished];
    return op;
}

- (AFHTTPRequestOperation *)syncGET:(NSString *)URLString
                         parameters:(NSDictionary *)parameters
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    return [self synchronouslyPerformMethod:@"GET" URLString:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
        
    }];
    
}

#pragma mark - push notification

- (void)pushGanbareTotalNotification {
    NSMutableDictionary *totalGanbareDic = [NSMutableDictionary dictionaryWithObject:_totalGanbareNumber forKey:@"totalGanbare"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kGBUpdateTotalGabareNotification object:nil userInfo:totalGanbareDic];
}

#pragma mark - auto login

- (void)callAPILogin {
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setObject:kGBMailAddress forKey:@"email"];
    [params setObject:@"1" forKey:@"loginType"];
    [params setObject:[kGBLoginPassWord encyptMD5] forKey:@"password"];
    [[GBRequestManager sharedManager] syncPOST:[NSString stringFromConst:gbURLSessions] parameters:params isShowLoadingView:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[STATUS_CODE] isEqualToNumber:[NSNumber numberWithInt:GB_CODE_SUCCESS]] ) {
            NSDictionary *data = [responseObject objectForKey:@"data"];
            NSString *token = [data objectForKey:@"token"];
            if (token) {
                [[GBRequestManager sharedManager] setToken:token];
                [kGBUserDefaults setValue:token forKey:kGBAuthTokenKey];
            }
            NSString *userID = [data objectForKey:@"userId"];
            if (userID.length > 0) {
                [kGBUserDefaults setObject:userID forKey:kGBUserIDKey];
            }
            [kGBUserDefaults synchronize];

            NSLog(@"token :%@, userid :%@",kGBAuthToken,kGBUserID);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - check internet connection

- (BOOL)connected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)showAlertError {
    if (!_alertNetworkError) {
        _alertNetworkError = [[UIAlertView alloc] initWithTitle:@"error"
                                                        message:@"conect network failed"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    }

    [_alertNetworkError show];
}

- (void)showNoInternetViewWithSelector:(SEL)selector {
    GBNoInternetView *noInternetView = [[GBNoInternetView alloc] initWithTarget:self selector:selector];
    [noInternetView show];
}

@end
