//
//  Client.h
//  Galleon
//
//  Created by Tang Zhixiong on 15/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^SuccessCompletionBlock)(id responseObject);
typedef void (^FailureCompletionBlock)(NSError *error, NSString *responseString);


@interface Client : NSObject

+ (Client *)sharedClient;

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

- (void)updateUserWithId:(NSString *)userId
            withNickName:(NSString *)nikeName
                    name:(NSString *)name
                   token:(NSString *)token
            successBlock:(SuccessCompletionBlock) successCompletionBlock
            failureBlock:(FailureCompletionBlock) failureCompletionBlock;

- (void)uploadImage:(UIImage *) image
       successBlock:(SuccessCompletionBlock) successCompletionBlock
       failureBlock:(FailureCompletionBlock) failureCompletionBlock;

- (void)updateUserWithId:(NSString *)userId
            withNickName:(NSString *)nikeName
                    name:(NSString *)name
                   token:(NSString *)token
           iconURLString:(NSString *)iconURLString
            successBlock:(SuccessCompletionBlock) successCompletionBlock
            failureBlock:(FailureCompletionBlock) failureCompletionBlock;

- (void)getMockImageURLWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                           failureBlock:(FailureCompletionBlock) failureCompletionBlock;

- (void)getAllMessagesWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                          failureBlock:(FailureCompletionBlock) failureCompletionBlock;

- (void)PostMessgeWithContent:(NSString *)contentString
                        token:(NSString *)token
                 successBlock:(SuccessCompletionBlock) successCompletionBlock
                 failureBlock:(FailureCompletionBlock) failureCompletionBlock;

- (void)getAllExhibitionsWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                             failureBlock:(FailureCompletionBlock) failureCompletionBlock;

- (void)getAllInformsWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                         failureBlock:(FailureCompletionBlock) failureCompletionBlock;

@end
