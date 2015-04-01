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
#import "User.h"

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
    [self updateUserWithName:@"aaa" userId:@"1" token:@"b6b22322c3be6bd06b8bd2911567bc1b:1419465662" password:nil headerImage:nil company:@"afa" job:@"fad" phone:@"fadf" email:@"heeh" successBlock:^(id resposeObject){
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
    [self uploadImage:image name:@"file" filename:@"ios.png" URL:@"news/user/upload_icon" parameter:nil successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)updateUserWithName:(NSString *)name
                   userId:(NSString *)userId
                     token:(NSString *)token
                  password:(NSString *)password
               headerImage:(NSString *)headerImage
                   company:(NSString *)company
                       job:(NSString *)job
                     phone:(NSString *)phone
                     email:(NSString *)email
              successBlock:(SuccessCompletionBlock) successCompletionBlock
              failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    //if (account)       param[@"account"] = account;
    if (password)      param[@"password"] = password;
    if (name)          param[@"name"] = name;
    if (company)       param[@"company"] = company;
    if (phone)         param[@"phone_number"] = phone;
    if (email)         param[@"email"] = email;
    if (job)           param[@"title"] = job;
    if (token)      param[@"token"]=token;
    NSString * urlString = [NSString stringWithFormat:@"/news/user/%@/update_user_profile",userId];
    [self POST:urlString parameter:param successBlock:^(id responseData){
        User * user = [[User alloc] init];
        [user loadWithDictionary:responseData];
        if (headerImage) {
            [self updateUserHeaderImage:headerImage token:user.token successBlock:^(id responseData){
                successCompletionBlock(responseData);
            } failureBlock:failureCompletionBlock];
        }
    } failureBlock:failureCompletionBlock];}

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

- (void)thumberANewsWithId:(NSString *) newsId
              successBlock:(SuccessCompletionBlock) successCompletionBlock
              failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    NSString * path = [NSString stringWithFormat:@"/news/news/%@/awesome",newsId];
    [self GET:path successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)updateUserHeaderImage:(NSString *)headerImage
                        token:(NSString *)token
                 successBlock:(SuccessCompletionBlock) successCompletionBlock
                 failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    if (headerImage)       param[@"header"] = headerImage;
    if (token)              param[@"token"] = token;
    [self POST:@"/news/user/update_header" parameter:param successBlock:successCompletionBlock failureBlock:failureCompletionBlock];
}

- (void)registerWithName:(NSString *)name
                 account:(NSString *)account
                password:(NSString *)password
             headerImage:(NSString *)headerImage
                 company:(NSString *)company
                     job:(NSString *)job
                   phone:(NSString *)phone
                   email:(NSString *)email
            successBlock:(SuccessCompletionBlock) successCompletionBlock
            failureBlock:(FailureCompletionBlock) failureCompletionBlock
{
    NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
    if (account)       param[@"account"] = account;
    if (password)      param[@"password"] = password;
    if (name)          param[@"name"] = name;
    if (company)       param[@"company"] = company;
    if (phone)         param[@"phone_number"] = phone;
    if (email)         param[@"email"] = email;
    if (job)           param[@"title"] = job;
    [self POST:@"/news/register" parameter:param successBlock:^(id responseData){
        User * user = [[User alloc] init];
        [user loadWithDictionary:responseData];
        if (headerImage) {
            [self updateUserHeaderImage:headerImage token:user.token successBlock:^(id responseData){
                successCompletionBlock(responseData);
            } failureBlock:failureCompletionBlock];
        }
    } failureBlock:failureCompletionBlock];
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
        [formData appendPartWithFileData:UIImagePNGRepresentation(image)
                                    name:name
                                fileName:filename
                                mimeType:@"image/png"];
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
