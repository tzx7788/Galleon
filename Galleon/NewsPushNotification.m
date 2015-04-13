//
//  NewsPushNotification.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/04/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "NewsPushNotification.h"
#import "NewsViewController.h"

@implementation NewsPushNotification

- (id)init
{
    self = [super init];
    if (self) {
        self.nibName = NSStringFromClass(NewsViewController.class);
    }
    return self;
}

- (NSString *)viewControllerClassName
{
    return NSStringFromClass(NewsViewController.class);
}

@end
