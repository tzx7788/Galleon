//
//  NewsModel.m
//  Galleon
//
//  Created by Tang Zhixiong on 16/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (void)loadDataWithDictionary:(NSDictionary *)dict
{
    id object = dict;
    if (object[@"id"]) self.newsId = object[@"id"];
    if (object[@"title"]) self.titleString = object[@"title"];
    if (object[@"icon"]) self.avatarURLString = object[@"icon"];
    if (object[@"create_time"]) self.date = object[@"create_time"];
    if (object[@"has_video"]) self.hasVideo = [object[@"has_video"] boolValue];
    if (object[@"video_link"]) self.videoURLString = object[@"video_link"];
    if (object[@"content"]) self.content = object[@"content"];
    if (object[@"awesome_count"]) self.thumbCount = object[@"awesome_count"];
    if (object[@"view_count"]) self.viewCount = object[@"view_count"];
}

@end
