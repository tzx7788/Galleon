//
//  InformModel.m
//  Galleon
//
//  Created by Tang Zhixiong on 22/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "InformModel.h"
#import "NSDate+Addition.h"

@implementation InformModel

- (void)loadWithDictionary:(NSDictionary *)dict
{
    if ( dict[@"title"] ) self.title = dict[@"title"];
    if ( dict[@"create_time"] ) self.createdTime = [NSDate covertFromString: dict[@"create_time"]];
    if ( dict[@"id"] ) self.informId = dict[@"id"];
}

@end
