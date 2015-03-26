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
    } failureBlock:^(NSError *error, NSString * responseString) {
        NSLog(@"%@",error);
    }];
//    [self getNewsWithsuccessBlock:^(id resposeObject){
//        NSLog(@"%@",resposeObject);
//    } failureBlock:^(NSError *error, NSString * responseString) {
//        NSLog(@"%@",error);
//    }];
//    [self updateUserWithId:@"1" withNickName:@"abc" name:@"bcd" token:@"b6b22322c3be6bd06b8bd2911567bc1b:1419465662" successBlock:^(id resposeObject){
//        NSLog(@"%@",resposeObject);
//    } failureBlock:^(NSError *error, NSString * responseString) {
//        NSLog(@"%@",error);
//    }];
    
//    [self uploadImage:[UIImage imageNamed:@"pic_1huiyijieshao"] successBlock:^(id resposeObject){
//                NSLog(@"%@",resposeObject);
//            } failureBlock:^(NSError *error, NSString * responseString) {
//                NSLog(@"%@",error);
//            }];
    
//    [self updateUserWithId:@"1" withNickName:@"abc" name:@"bcd" token:@"b6b22322c3be6bd06b8bd2911567bc1b:1419465662" iconURLString:@"ios.jpg" successBlock:^(id resposeObject){
//            NSLog(@"%@",resposeObject);
//        } failureBlock:^(NSError *error, NSString * responseString) {
//            NSLog(@"%@",error);
//        }];
    
//    [self getMockImageURLWithsuccessBlock:^(id resposeObject){
//                    NSLog(@"%@",resposeObject);
//                } failureBlock:^(NSError *error, NSString * responseString) {
//                    NSLog(@"%@",error);
//                }];
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

- (void)getNewsDetialWithId:(NSString *)newsId
               successBlock:(SuccessCompletionBlock) successCompletionBlock
               failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self GET:[NSString stringWithFormat:@"/news/news/%@",newsId] successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)updateUserWithId:(NSString *)userId
            withNickName:(NSString *)nikeName
                    name:(NSString *)name
                   token:(NSString *)token
            successBlock:(SuccessCompletionBlock) successCompletionBlock
            failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    if (name)       param[@"name"]= name;
    if (nikeName)   param[@"nickname"] = nikeName;
    if (token)      param[@"token"]=token;
    NSString * urlString = [NSString stringWithFormat:@"/news/user/%@/update_name",userId];
    [self POST:urlString parameter:param successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)uploadImage:(UIImage *) image
       successBlock:(SuccessCompletionBlock) successCompletionBlock
       failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self uploadImage:image name:@"file" filename:@"ios.jpg" URL:@"news/user/upload_icon" parameter:nil successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)updateUserWithId:(NSString *)userId
            withNickName:(NSString *)nikeName
                    name:(NSString *)name
                   token:(NSString *)token
           iconURLString:(NSString *)iconURLString
            successBlock:(SuccessCompletionBlock) successCompletionBlock
            failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    if (name)       param[@"name"]= name;
    if (nikeName)   param[@"nickname"] = nikeName;
    if (token)      param[@"token"]=token;
    if (iconURLString) param[@"header"] = iconURLString;
    NSString * urlString = [NSString stringWithFormat:@"/news/user/%@/update_profile",userId];
    [self POST:urlString parameter:param successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)getMockImageURLWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                           failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self GET:@"/news/mockimage" successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)getAllMessagesWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                          failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self GET:@"/news/messages" successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)PostMessgeWithContent:(NSString *)contentString
                        token:(NSString *)token
                 successBlock:(SuccessCompletionBlock) successCompletionBlock
                 failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    if (contentString)       param[@"content"]= contentString;
    if (token)               param[@"token"]=token;
    [self POST:@"/news/message/send" parameter:param successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)getAllExhibitionsWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                             failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self GET:@"/news/conferences/list/ios" successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)getExhibitionWithId:(NSString *)exhibitionId
               successBlock:(SuccessCompletionBlock) successCompletionBlock
               failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self GET:[NSString stringWithFormat:@"/news/conferences/%@",exhibitionId] successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)getExhibitionPDFlistWithId:(NSString *)exhibitionId
               successBlock:(SuccessCompletionBlock) successCompletionBlock
               failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self GET:[NSString stringWithFormat:@"news/conferences/%@/get_file/REPORT",exhibitionId] successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)getAllInformsWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                         failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self GET:@"/news/informs" successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)getAllNewImageWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                          failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self GET:@"/news/mainpage_images" successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)getCountDownExhibitionWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                                  failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self GET:@"/news/conferences/in_time_conference" successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)getSystemTimeWithsuccessBlock:(SuccessCompletionBlock) successCompletionBlock
                         failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self GET:@"/news/system_time" successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
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
        NSLog(@"%@",operation.request);
        NSLog(@"%@",[operation.request allHTTPHeaderFields]);
        NSLog(@"%@",param);
        if (failureCompletionBlock)
            failureCompletionBlock(error,nil);
    }];
}

- (void)uploadImage:(UIImage *) image
               name:(NSString *)name
           filename:(NSString *) filename
                URL:(NSString *) urlString
          parameter:(id) param
       successBlock:(SuccessCompletionBlock) successCompletionBlock
       failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    [self.manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 1.0)
                                    name:name
                                fileName:filename
                                mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id resposeObject){
        if (successCompletionBlock)
            successCompletionBlock(resposeObject);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error){
        NSLog(@"%@",operation.request);
        NSLog(@"%@",[operation.request allHTTPHeaderFields]);
        NSLog(@"%@",param);
        NSLog(@"%@", error);
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
        NSLog(@"%@",operation.request);
        NSLog(@"%@",[operation.request allHTTPHeaderFields]);
        NSLog(@"%@", error);
        if (failureCompletionBlock)
            failureCompletionBlock(error,nil);
    }];
}

@end
