//
//  NewsListPushNotification.m
//  Galleon
//
//  Created by Tang Zhixiong on 16/04/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "NewsListPushNotification.h"
#import "NewsListViewController.h"

@implementation NewsListPushNotification

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        self.nibName = NSStringFromClass(NewsListViewController.class);
    }
    return self;
}

- (NSString *)viewControllerClassName
{
    return NSStringFromClass(NewsListViewController.class);
}

@end
