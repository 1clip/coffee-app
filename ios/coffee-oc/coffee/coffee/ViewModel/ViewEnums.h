//
//  ViewEnums.h
//  coffee
//
//  Created by wang xuan on 14/12/16.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HangoutParticipatorState) {
    Pending  = 0,
    Accept  = 1,
    Cancel  = 2,
    Unknown = 3
};

@interface CoffeeUIColor : NSObject

+(UIColor*) AcceptColor;
+(UIColor*) AcceptBorderColor;

+(UIColor*) CancelColor;
+(UIColor*) CancelBorderColor;

+(UIColor*) OverdueColor;
+(UIColor*) OverdueBorderColor;

+(UIColor*) PendingColor;
+(UIColor*) PendingBorderColor;

+(UIColor*) GrayBackgroundColor;

+(UIColor*) MainPageBorderColor;
+(UIColor*) MainPageFontColor;
+(UIColor*) AddActivityFontColor;
+(UIColor*) SWButtonBackgroundColor;
+(UIColor*) BlackColorForAlpha;

@end