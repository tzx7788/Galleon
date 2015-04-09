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
    if ( dict[@"content"] )
        self.content = dict[@"content"];
    if ( dict[@"created_time"] )
        self.date = [NSDate covertFromString:dict[@"created_time"]];
    if ( dict[@"user"] ) {
        if ( dict[@"user"][@"header_small"] )
            self.avatarURLString = dict[@"user"][@"header_small"];
        if ( dict[@"user"][@"name"] )
            self.name = dict[@"user"][@"name"];
        if ( dict[@"user"][@"company"] )
            self.company = dict[@"user"][@"company"];
    }
}

@end
