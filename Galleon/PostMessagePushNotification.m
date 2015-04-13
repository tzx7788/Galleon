//
//  PostMessagePushNotification.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/04/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "PostMessagePushNotification.h"
#import "PostMessageViewController.h"
#import "StringConstant.h"

@implementation PostMessagePushNotification
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nibName = NSStringFromClass(PostMessageViewController.class);
        self.title = PostMessage;
    }
    return self;
}

- (NSString *)viewControllerClassName
{
    return NSStringFromClass(PostMessageViewController.class);
}

@end
