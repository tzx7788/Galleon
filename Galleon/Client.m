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
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    });
    return client;
}

- (void) test
{
    //[self.manager.requestSerializer setValue:@"application/json;odata=verbose" forHTTPHeaderField:@"Content-Type"];
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    param[@"account"] = @"system";
    param[@"password"] = @"1234";
    [self.manager POST:@"/news/login" parameters:param success:^(AFHTTPRequestOperation *operation, id resposeObject){
        NSLog(@"yes");
        NSLog(@"%@",resposeObject);
    }failure:nil];
}

- (void)enqueueTokenRequest:(GRequest *)rawRequest
{
}

@end
