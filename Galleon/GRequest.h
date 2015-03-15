//
//  GRequest.h
//  Galleon
//
//  Created by Tang Zhixiong on 15/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#define HttpMethodGET           @"GET"
#define HttpMethodPOST          @"POST"
#define HttpMethodPUT           @"PUT"
#define HttpMethodPATCH         @"PATCH"
#define HttpMethodDELETE        @"DELETE"

typedef void (^SuccessCompletionBlock)(id responseObject);
typedef void (^FailureCompletionBlock)(NSError *error, NSString *responseString);

@interface GRequest : NSObject

@property (nonatomic, strong) NSString * URLString;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *HTTPMethod;

@property (nonatomic, copy) SuccessCompletionBlock successCompletionBlock;
@property (nonatomic, copy) FailureCompletionBlock failureCompletionBlock;

+ (GRequest *)requestWithSuccessBlock:(SuccessCompletionBlock)success
                          failureBlock:(FailureCompletionBlock)failure;

@end
