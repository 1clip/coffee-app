//
//  Enums.h
//  coffee
//
//  Created by achiel on 14-10-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gender : NSObject

+(NSString*) Male;
+(NSString*) Female;

@end

@interface HangoutState : NSObject

+(NSString*) Active;
+(NSString*) Overdue;

@end

@interface ParticipatorRole : NSObject

+(NSString*) Organizer;
+(NSString*) Invitee;

@end

@interface ParticipatorState : NSObject

+(NSString*) Pending;
+(NSString*) Accept;
+(NSString*) Reject;

@end
