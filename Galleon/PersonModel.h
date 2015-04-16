//
//  PersonModel.h
//  Galleon
//
//  Created by Tang Zhixiong on 17/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "SuperModel.h"

@interface PersonModel : SuperModel

@property (nonatomic, strong) User * user;

@end
