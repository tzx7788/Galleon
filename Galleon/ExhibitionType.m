//
//  ExhibitionType.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionType.h"
#import "StringConstant.h"
#import "ImageConstant.h"
#import "NotificationConstant.h"

@implementation ExhibitionType

- (void) setType:(ExhibtionCategoryType)type
{
    _type = type;
    switch (type) {
        case ExhibitionTypeIntro:
            self.name = ExhibitionIntroduce;
            self.backGroundImage = ExhibitionIntroduceBackGround;
            self.notificationName = NotificationExhibitionIntroduce;
            break;
        case ExhibitionTypeService:
            self.name = ExhibitionService;
            self.backGroundImage = ExhibitionServiceBackGround;
            self.notificationName = NotificationExhibitionService;
            break;
        case ExhibitionTypeHost:
            self.name = ExhibitionHost;
            self.backGroundImage = ExhibitionHostBackGround;
            self.notificationName = NotificationExhibitionHost;
            break;
        case ExhibitionTypeSche:
            self.name = ExhibitionSchedule;
            self.backGroundImage = ExhibitionScheduleBackGround;
            self.notificationName = NotificationExhibitionSchedule;
            break;
        case ExhibitionTypeLayout:
            self.name = Exhibitionlayout;
            self.backGroundImage = ExhibitionlayoutBackGround;
            self.notificationName = NotificationExhibitionlayout;
            break;
        case ExhibitionTypeDownload:
            self.name = ExhibitionDownloads;
            self.backGroundImage = ExhibitionDownloadsBackGround;
            self.notificationName = NotificationExhibitionDownloads;
            break;
        default:
            break;
    }
}

@end
