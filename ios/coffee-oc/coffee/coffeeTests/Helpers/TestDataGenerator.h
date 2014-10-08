//
//  TestDataGenerator.h
//  coffee
//
//  Created by achiel on 14-10-8.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModels.h"

typedef NS_ENUM(NSInteger, IdType) {
    IdTypeUser = 0,
    IdTypeGroup = 1,
    IdTypeHangout = 2,
    IdTypeAvatar = 3,
};

@interface TestDataGenerator : NSObject

#pragma mark Base
+(AvatarInfo*) avatarInfo;
+(long) randomIdWithType:(IdType)idType;

#pragma mark User
+(User*) user;
+(User*) userWithPrefix:(NSString*)lNamePrefix;
+(User*) userWithPrefix:(NSString *)lNamePrefix needId:(BOOL)needId;

#pragma mark Hangout
+(Hangout*) hangoutNeedId:(BOOL)needId;
+(Hangout*) hangoutWithOId:(long)organizerId;
+(Hangout*) hangoutWithOId:(long)organizerId needId:(BOOL)needId;

#pragma mark Group
+(Group*) group;
+(Group*) groupNeedId:(BOOL)needId;
+(Group*) groupNeedId:(BOOL)needId needFriends:(BOOL)needFriends;

+(Friend*) friend;
+(Friend*) friendNeedGroups:(BOOL)needGroups;

@end
