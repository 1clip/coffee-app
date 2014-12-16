//
//  UIHelper.h
//  coffee
//
//  Created by wang xuan on 14/12/16.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"
#import "ViewEnums.h"

@interface UIHelper : NSObject

+(UIColor*) GetBackgroundColorByParticateState: (NSString *) particateState;

+(UIColor*) GetBorderColorByParticateState:(NSString *)particateState;

+(NSString *)DisplayHangoutDate:(NSDate *)date;

+(HangoutParticipatorState) ConvertToParticipatorEnum:(NSString *) state;

+(UIImage*) FindAddressButtonImage:(NSString *) particateState;

+(UIImage*) FindBadgeImageByStatus:(NSString *) particateState;

+(NSString *) MapActiveImage: (NSString *) activityName;

+(NSString *) MapActivePureImage: (NSString *) activityName;


@end
