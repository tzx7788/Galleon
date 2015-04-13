//
//  PostMessageModel.h
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuperModel.h"
#import "User.h"

@interface PostMessageModel : SuperModel

@property (nonatomic, strong) User * user;

@end
