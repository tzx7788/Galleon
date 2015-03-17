//
//  Client.h
//  Galleon
//
//  Created by Tang Zhixiong on 15/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessCompletionBlock)(id responseObject);
typedef void (^FailureCompletionBlock)(NSError *error, NSString *responseString);


@interface Client : NSObject

+ (Client *)sharedClient;

@property (nonatomic, copy) SuccessCompletionBlock successCompletionBlock;
@property (nonatomic, copy) FailureCompletionBlock failureCompletionBlock;

- (void) testPost;

- (void)loginWithAccount:(NSString *) account
                Password:(NSString *) password
            successBlock:(SuccessCompletionBlock) successCompletionBlock
            failureBlock:(FailureCompletionBlock) failureCompletionBlock;

- (void)getNewsWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                   failureBlock:(FailureCompletionBlock) failureCompletionBlock;

- (void)getNewsDetialWithId:(NSString *)newsId
               successBlock:(SuccessCompletionBlock) successCompletionBlock
               failureBlock:(FailureCompletionBlock) failureCompletionBlock;

@end
