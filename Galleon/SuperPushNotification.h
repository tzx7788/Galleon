//
//  SuperPushNotification.h
//  Galleon
//
//  Created by Tang Zhixiong on 12/04/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuperModel.h"

@interface SuperPushNotification : NSObject

@property (readonly) NSString * viewControllerClassName;

@property (nonatomic,strong) NSString * nibName;

@property (nonatomic,strong) NSString * title;

@property (nonatomic,strong) SuperModel * model;

@end
