//
//  User.m
//  Galleon
//
//  Created by Tang Zhixiong on 19/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "User.h"

@implementation User

+ (void)saveToCache:(User *)user
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:user.account forKey:@"account"];
    [ud setObject:user.company forKey:@"company"];
    [ud setObject:user.descript forKey:@"descript"];
    [ud setObject:user.email forKey:@"email"];
    [ud setObject:user.iconImageURLString forKey:@"icon"];
    [ud setObject:user.userId forKey:@"userId"];
    [ud setObject:user.isActive forKey:@"isActive"];
    [ud setObject:user.isVIP forKey:@"isVIP"];
    [ud setObject:user.lastLogInTime forKey:@"lastLogInTime"];
    [ud setObject:user.myattr forKey:@"myattr"];
    [ud setObject:user.name forKey:@"name"];
    [ud setObject:user.nickName forKey:@"nickName"];
    [ud setObject:user.password forKey:@"password"];
    [ud setObject:user.phone forKey:@"phone"];
    [ud setObject:user.registeredTime forKey:@"registeredTime"];
    [ud setObject:user.role forKey:@"role"];
    [ud setObject:user.token forKey:@"token"];
    [ud setObject:user.autoLogin forKey:@"autoLogin"];
}

+ (User *)awakeFromCache
{
    User * user = [[User alloc] init];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    user.account = [ud objectForKey:@"account"];
    user.company = [ud objectForKey:@"company"];
    user.descript = [ud objectForKey:@"descript"];
    user.email = [ud objectForKey:@"email"];
    user.iconImageURLString = [ud objectForKey:@"icon"];
    user.userId = [ud objectForKey:@"userId"];
    user.isActive = [ud objectForKey:@"isActive"];
    user.isVIP = [ud objectForKey:@"isVIP"];
    user.lastLogInTime = [ud objectForKey:@"lastLogInTime"];
    user.myattr = [ud objectForKey:@"myattr"];
    user.name = [ud objectForKey:@"name"];
    user.nickName = [ud objectForKey:@"nickName"];
    user.password = [ud objectForKey:@"password"];
    user.phone = [ud objectForKey:@"phone"];
    user.registeredTime = [ud objectForKey:@"registeredTime"];
    user.role = [ud objectForKey:@"role"];
    user.token = [ud objectForKey:@"token"];
    user.autoLogin = [ud objectForKey:@"autoLogin"];
    return user;
}

+ (void)clearCache
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:nil forKey:@"account"];
    [ud setObject:nil forKey:@"company"];
    [ud setObject:nil forKey:@"descript"];
    [ud setObject:nil forKey:@"email"];
    [ud setObject:nil forKey:@"icon"];
    [ud setObject:nil forKey:@"userId"];
    [ud setObject:nil forKey:@"isActive"];
    [ud setObject:nil forKey:@"isVIP"];
    [ud setObject:nil forKey:@"lastLogInTime"];
    [ud setObject:nil forKey:@"myattr"];
    [ud setObject:nil forKey:@"name"];
    [ud setObject:nil forKey:@"nickName"];
    [ud setObject:nil forKey:@"password"];
    [ud setObject:nil forKey:@"phone"];
    [ud setObject:nil forKey:@"registeredTime"];
    [ud setObject:nil forKey:@"role"];
    [ud setObject:nil forKey:@"token"];
    [ud setObject:nil forKey:@"autoLogin"];
}

@end
