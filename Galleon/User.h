//
//  User.h
//  Galleon
//
//  Created by Tang Zhixiong on 19/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString * account;
@property (nonatomic, strong) NSString * company;
@property (nonatomic, strong) NSString * descript;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * iconImageURLString;
@property (nonatomic, strong) NSString * userId;
@property (nonatomic, strong) NSNumber * isActive;
@property (nonatomic, strong) NSNumber * isVIP;
@property (nonatomic, strong) NSDate * lastLogInTime;
@property (nonatomic, strong) NSString * myattr;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * registeredTime;
@property (nonatomic, strong) NSString * role;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSNumber * autoLogin;

+ (void)saveToCache:(User *) user;
+ (User *)awakeFromCache;
+ (void)clearCache;

@end
