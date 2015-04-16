//
//  ExhibitionDetailPushNotification.m
//  Galleon
//
//  Created by Tang Zhixiong on 16/04/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionDetailPushNotification.h"
#import "ExhibitionDetailViewController.h"

@implementation ExhibitionDetailPushNotification

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        self.nibName = NSStringFromClass(ExhibitionDetailViewController.class);
    }
    return self;
}

- (NSString *)viewControllerClassName
{
    return NSStringFromClass(ExhibitionDetailViewController.class);
}

@end
