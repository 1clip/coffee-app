//
//  Enums.m
//  coffee
//
//  Created by achiel on 14-10-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "Enums.h"

@implementation Gender

+(NSString*) Male
{
    return @"male";
}

+(NSString*) Female
{
    return @"female";
}

@end

@implementation HangoutState

+(NSString*) Active
{
    return @"active";
}

+(NSString*) Overdue
{
    return @"overdue";
}

@end

@implementation ParticipatorRole

+(NSString*) Organizer
{
    return @"organizer";
}

+(NSString*) Invitee
{
    return @"invitee";
}

@end

@implementation ParticipatorState

+(NSString*) Pending
{
    return @"pending";
}

+(NSString*) Accept
{
    return @"accept";
}

+(NSString*) Reject
{
    return @"reject";
}

@end
