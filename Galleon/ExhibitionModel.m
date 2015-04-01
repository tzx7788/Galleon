//
//  ExhibitionModel.m
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import "ExhibitionModel.h"
#import "NotificationConstant.h"
#import "StringConstant.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import "NSDate+Addition.h"

@interface ExhibitionModel()<EKEventEditViewDelegate>

@end

@implementation ExhibitionModel

- (void)loadWithDictionary:(NSDictionary *)dict
{
    if (dict[@"view_count"]) self.viewCount = dict[@"view_count"];
    if (dict[@"started_time"]) self.startedTime = [NSDate covertFromString:dict[@"started_time"]];
    if (dict[@"updated_time"]) self.updatedTime = [NSDate covertFromString:dict[@"updated_time"]];
    if (dict[@"created_time"]) self.createdTime = [NSDate covertFromString:dict[@"created_time"]];
    if (dict[@"id"]) self.exhibitionId = dict[@"id"];
    if (dict[@"title"]) self.exhibitionName = dict[@"title"];
    if (dict[@"logistics_content"]) self.serviceContent = dict[@"logistics_content"];
    if (dict[@"group_content"]) self.hostContent = dict[@"group_content"];
    if (dict[@"agenda_content"]) self.scheduleContent = dict[@"agenda_content"];
    if (dict[@"layout_content"]) self.layoutContent = dict[@"layout_content"];
    if (dict[@"intro_content"]) self.introContent = dict[@"intro_content"];
}

- (void)saveToCalendarWithViewController:(UIViewController *)vc
{
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        EKEventEditViewController* controller = [[EKEventEditViewController alloc] init];
        controller.eventStore = store;
        controller.editViewDelegate = self;
        EKEvent * event = [EKEvent eventWithEventStore:store];
        event.title = self.exhibitionName;
        event.startDate = self.startedTime;
        event.endDate = self.startedTime;
        event.allDay = YES;
        event.calendar = [store defaultCalendarForNewEvents];
        controller.event = event;
        [vc presentViewController:controller animated:YES completion:nil];
    }];
}

- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action
{
    NSError * error = nil;
    if ( action == EKEventEditViewActionSaved )
    {
        [controller.eventStore saveEvent:controller.event span:EKSpanThisEvent commit:YES error:&error];
        if ( error ) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWarningMessage object:OperationFailed];
        } else {
            [controller dismissViewControllerAnimated:YES completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWarningMessage object:OperationSuccessful];
        }
    }
}

@end
