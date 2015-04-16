//
//  FileListPushNotification.m
//  Galleon
//
//  Created by Tang Zhixiong on 16/04/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "FileListPushNotification.h"
#import "ExhibitionFileListViewController.h"

@implementation FileListPushNotification

- (instancetype)init
{
    self = [super init];
    if ( self ) {
        self.nibName = NSStringFromClass(ExhibitionFileListViewController.class);
    }
    return self;
}

- (NSString *)viewControllerClassName
{
    return NSStringFromClass(ExhibitionFileListViewController.class);;
}

@end
