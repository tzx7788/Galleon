//
//  MessageModel.m
//  Galleon
//
//  Created by Tang Zhixiong on 18/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "MessageModel.h"
#import "NSDate+Addition.h"

@implementation MessageModel

- (void)loadDataWithDictionary:(NSDictionary *)dict
{
    self.avatarURLString = dict[@"user"][@"header_small"];
    self.content = dict[@"content"];
    self.date = [NSDate covertFromString:dict[@"created_time"]];
    self.name = dict[@"user"][@"name"];
}

@end
