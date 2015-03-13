//
//  ExhibitionType.h
//  Galleon
//
//  Created by Tang Zhixiong on 13/03/2015.
//  Copyright (c) 2015 Tang Zhixiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    ExhibitionTypeIntro = 0,
    ExhibitionTypeService,
    ExhibitionTypeHost,
    ExhibitionTypeSche,
    ExhibitionTypeLayout,
    ExhibitionTypeDownload,
} ExhibtionCategoryType;

@interface ExhibitionType : NSObject

@property (nonatomic,assign) ExhibtionCategoryType type;

@property (nonatomic,strong) UIImage  * backGroundImage;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * notificationName;

@end
