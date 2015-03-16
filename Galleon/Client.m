//
//  Client.m
//  Galleon
//
//  Created by Tang Zhixiong on 15/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "Client.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>

@interface Client()
@property (strong,nonatomic) AFHTTPRequestOperationManager * manager;
@end

@implementation Client

+ (Client *) sharedClient
{
    static Client *client = nil;
    static dispatch_once_t ClientPredicate;
    dispatch_once(&ClientPredicate, ^{
        client = [[Client alloc] init];
        client.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://aero.wisdomriver.com.cn/"]];
        client.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        client.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        client.manager.responseSerializer.acceptableContentTypes = [client.manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    });
    return client;
}

- (void) testPost
{
//    [self.manager.requestSerializer setValue:@"application/json;odata=verbose" forHTTPHeaderField:@"Content-Type"];
//    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
//    param[@"account"] = @"system";
//    param[@"password"] = @"1234";
//    [self.manager POST:@"/news/login" parameters:param success:^(AFHTTPRequestOperation *operation, id resposeObject){
//        NSLog(@"yes");
//        NSLog(@"%@",resposeObject);
//    }failure:nil];
    [self loginWithAccount:@"system" Password:@"1234"
    successBlock:^(id resposeObject){
        NSLog(@"%@",resposeObject);
    } failureBlock:nil];
//    [self getNewsWithsuccessBlock:^(id resposeObject){
//        NSLog(@"%@",resposeObject);
//    } failureBlock:nil];
}

- (void)loginWithAccount:(NSString *) account
                Password:(NSString *) password
            successBlock:(SuccessCompletionBlock) successCompletionBlock
            failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    if (account) param[@"account"] = account;
    if (password)param[@"password"] = password;
    [self POST:@"/news/login" parameter:param successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)getNewsWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                   failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self GET:@"/news/simple_news"successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

#pragma PrivateMethod
- (void)POST:(NSString *) urlString
   parameter:(id) param
successBlock:(SuccessCompletionBlock) successCompletionBlock
failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self.manager POST:urlString parameters:param success:^(AFHTTPRequestOperation *operation, id resposeObject){
        if (successCompletionBlock)
            successCompletionBlock(resposeObject);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error){
        if (failureCompletionBlock)
            failureCompletionBlock(error,nil);
    }];
}


- (void)GET:(NSString *) urlString
successBlock:(SuccessCompletionBlock) successCompletionBlock
failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self.manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id resposeObject){
        if (successCompletionBlock)
            successCompletionBlock(resposeObject);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error){
        if (failureCompletionBlock)
            failureCompletionBlock(error,nil);
    }];
}

@end
