//
//  ExhibitionModel.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionModel.h"

@implementation ExhibitionModel

- (void)loadWithDictionary:(NSDictionary *)dict
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    if (dict[@"view_count"]) self.viewCount = dict[@"view_count"];
    if (dict[@"started_time"]) self.startedTime = [formatter dateFromString:dict[@"started_time"]];
    if (dict[@"updated_time"]) self.updatedTime = dict[@"updated_time"];
    if (dict[@"created_time"]) self.createdTime = dict[@"created_time"];
    if (dict[@"id"]) self.exhibitionId = dict[@"id"];
    if (dict[@"title"]) self.exhibitionName = dict[@"title"];
    if (dict[@"logistics_content"]) self.serviceContent = dict[@"logistics_content"];
    if (dict[@"group_content"]) self.hostContent = dict[@"group_content"];
    if (dict[@"agenda_content"]) self.scheduleContent = dict[@"agenda_content"];
    if (dict[@"layout_content"]) self.layoutContent = dict[@"layout_content"];
    if (dict[@"intro_content"]) self.introContent = dict[@"intro_content"];
}

@end
