//
//  AppDelegate.m
//  Galleon
//
//  Created by Tang Zhixiong on 09/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "Client.h"
#import "APService.h"

@interface AppDelegate ()
@property (strong, nonatomic) UIImageView *splashView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
    
    self.splashView = [[UIImageView alloc]initWithFrame:self.window.bounds];
    [APService setupWithOption:launchOptions];
    [self displaySplashView];
    return YES;
}

- (void)displaySplashView
{
    [self.window makeKeyAndVisible];
    [self.window addSubview:self.splashView];
    [self.window bringSubviewToFront:self.splashView];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [self.splashView setImageWithURL:[NSURL URLWithString:[ud objectForKey:@"SplashViewURL"]] placeholderImage:[UIImage imageNamed:@"bg_about_us"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5f animations:^{
            [self.splashView setAlpha:0.0f];
        } completion:^(BOOL isFinished){
            [self.splashView removeFromSuperview];
            [self.splashView setAlpha:1.0f];
        }];
    });
    [[Client sharedClient] getMockImageURLWithsuccessBlock:^(id responseData){
        if (responseData[@"url"]) {
            [ud setObject:responseData[@"url"] forKey:@"SplashViewURL"];
            [self.splashView setImageWithURL:[NSURL URLWithString:[ud objectForKey:@"SplashViewURL"]] placeholderImage:[UIImage imageNamed:@"bg_about_us"]];
        }
    } failureBlock:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"%@",error);
}


@end
