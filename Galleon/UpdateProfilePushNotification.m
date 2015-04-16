//
//  UpdateProfilePushNotification.m
//  Galleon
//
//  Created by Tang Zhixiong on 16/04/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "UpdateProfilePushNotification.h"
#import "UpdateProfileViewController.h"

@implementation UpdateProfilePushNotification

-(instancetype)init
{
    self = [super init];
    if ( self ) {
        self.nibName = NSStringFromClass(UpdateProfileViewController.class);
    }
    return self;
}

- (NSString *)viewControllerClassName
{
    return self.nibName = NSStringFromClass(UpdateProfileViewController.class);
}

@end
