//
//  UIHelper.m
//  coffee
//
//  Created by wang xuan on 14/12/16.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "UIHelper.h"
#import "ViewEnums.h"

@implementation UIHelper

+(UIColor*) GetBackgroundColorByParticateState:(NSString *)particateState
{
    if(particateState == [ParticipatorState Pending])
        return [CoffeeUIColor PendingColor];
    
    else if(particateState == [ParticipatorState Accept])
        return [CoffeeUIColor AcceptColor];
    
    else if(particateState == [ParticipatorState Reject])
        return [CoffeeUIColor CancelColor];
    
    return [UIColor clearColor];
}

+(UIColor*) GetBorderColorByParticateState:(NSString *)particateState
{
    if(particateState == [ParticipatorState Pending])
        return [CoffeeUIColor PendingBorderColor];
    
    else if(particateState == [ParticipatorState Accept])
        return [CoffeeUIColor AcceptBorderColor];
    
    else if(particateState == [ParticipatorState Reject])
        return [CoffeeUIColor CancelBorderColor];
    
    return [UIColor clearColor];
}


+ (NSString *)DisplayHangoutDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

+ (NSString *)DisplayHangoutTime:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}

+(HangoutParticipatorState) ConvertToParticipatorEnum:(NSString *) state
{
    if(state == [ParticipatorState Accept])
    {
        return Accept;
    }
    else if(state == [ParticipatorState Pending])
    {
        return Pending;
    }
    else if(state == [ParticipatorState Reject])
    {
        return Cancel;
    }
    else return Unknown;
}


+(UIImage*) FindAddressButtonImage:(NSString *) particateState
{
    if(particateState == [ParticipatorState Accept])
        return [UIImage imageNamed:@"AddressButton"];
    else if(particateState == [ParticipatorState Pending])
        return [UIImage imageNamed:@"Address_Pending"];
    else if(particateState == [ParticipatorState Reject])
        return [UIImage imageNamed:@"AddressButton"];
    
    return nil;
}

+(UIImage*) FindBadgeImageByStatus:(NSString *) particateState
{
    if(particateState == [ParticipatorState Pending])
        return [UIImage imageNamed:@"Details_Pending"];
    else if(particateState == [ParticipatorState Accept])
        return [UIImage imageNamed:@"Details_Accept"];
    else if(particateState == [ParticipatorState Reject])
        return [UIImage imageNamed:@"Details_Cancel"];
    
    return nil;
}


+(NSString *) MapActiveImage: (NSString *) activityName
{
    return [NSString stringWithFormat:@"Activity_%@", activityName];

}


+(NSString *) MapActivePureImage: (NSString *) activityName
{
   return [NSString stringWithFormat:@"%@_Big", activityName];
}
@end
