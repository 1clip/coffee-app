//
//  TestDataGenerator.m
//  coffee
//
//  Created by achiel on 14-10-8.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <stdlib.h>
#import "TestDataGenerator.h"

#pragma mark -

static int const
    sequenceBits = 10
    , workerIdBits = 6
    , timeStampBits = 40
    , workerIdShift = sequenceBits
    , timestampLeftShift = sequenceBits + workerIdBits
    , idTypeShift = sequenceBits + workerIdBits + timeStampBits;

static int const
    maxWorkerId = ~(-1 << workerIdBits)
    , maxSequenceId = ~(-1 << sequenceBits);

static int RandomInt(int max) {
    return arc4random_uniform(max);
}


@interface TestDataGenerator (private)

+(Participator*) participator;

@end

@implementation TestDataGenerator

#pragma mark Base
+(long) randomIdWithType:(IdType)idType {
    long timeTick = [NSDate timeIntervalSinceReferenceDate] * 1000;
    int workerId = arc4random_uniform(maxWorkerId);
    int sequenceId = arc4random_uniform(maxSequenceId);
    
    return (long)idType << idTypeShift |
        timeTick << timestampLeftShift |
        workerId << workerIdShift |
        sequenceId;
}

+(AvatarInfo*) avatarInfo {
    AvatarInfo* avatarInfo = [[AvatarInfo alloc] init];
    avatarInfo.id = [self randomIdWithType:IdTypeAvatar];
    avatarInfo.token = avatarInfo.id;
    
    return avatarInfo;
}

#pragma mark User
+(User*) user {
    return [self userWithPrefix:@"tom_slick"];
}

+(User*) userWithPrefix:(NSString*)lNamePrefix {
    return [self userWithPrefix:lNamePrefix needId:NO];
}

+(User*) userWithPrefix:(NSString *)lNamePrefix needId:(BOOL)needId {
    User* user = [[User alloc] init];
    
    if (needId) {
        user.id = [self randomIdWithType:IdTypeUser];
    }
    user.loginName = [NSString stringWithFormat:@"%@_%d", lNamePrefix, RandomInt(10)];
    user.friendlyName = [NSString stringWithFormat:@"%@ friendly name", user.loginName];
    user.locale = @"US";
    user.gender = RandomInt(2) == 0 ? [Gender Male] : [Gender Female];
    user.birth = @"1980-01-01";
    user.cellPhone = @"+1 (415) 123-456";
    user.signUpSource = @"cell_phone";
    user.avatarInfo = [self avatarInfo];
    
    return user;
}

#pragma mark Hangout
+(Hangout*) hangoutNeedId:(BOOL)needId {
    return [self hangoutWithOId:[self randomIdWithType:IdTypeUser] needId:needId];
}

+(Hangout*) hangoutWithOId:(long)organizerId {
    return [self hangoutWithOId:organizerId needId:NO];
}

+(Hangout*) hangoutWithOId:(long)organizerId needId:(BOOL)needId {
    Hangout* hangout = [[Hangout alloc] init];
    
    if (needId) {
        hangout.id = [self randomIdWithType:IdTypeHangout];
    }
    hangout.activity = @"Dinner";
    hangout.subject = @"My Birthday";
    hangout.location = @"123 Pie Street, San Francisco, CS";
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    now -= fmod(now, 1);
    hangout.startTime = [NSDate dateWithTimeIntervalSince1970:now];
    hangout.endTime = [hangout.startTime dateByAddingTimeInterval: RandomInt(10000) + 1000];
    
    int numParticipator = RandomInt(5) + 1;
    for (int i=0; i < numParticipator; ++i) {
        [hangout.participators addObject:[self participator]];
    }
    
    return hangout;
}

+(Participator*) participator {
    Participator* participator = [[Participator alloc] init];
    
    participator.id = [self randomIdWithType:IdTypeUser];
    
    return participator;
}

#pragma mark Group
+(Group*) group {
    return [self groupNeedId:NO];
}

+(Group*) groupNeedId:(BOOL)needId {
    return [self groupNeedId:needId needFriends:YES];
}

+(Group*) groupNeedId:(BOOL)needId needFriends:(BOOL)needFriends {
    Group* group = [[Group alloc] init];
    
    if (needId) {
        group.id = [self randomIdWithType:IdTypeGroup];
    }
    group.name = [NSString stringWithFormat:@"%@ %d", @"Colleagues", RandomInt(5)];
    
    if (needFriends) {
        int numFriends = RandomInt(5) + 1;
        for (int i=0; i < numFriends; ++i) {
            [group.friends addObject:[self friendNeedGroups:NO]];
        }
    }
    
    return group;
}

+(Friend*) friend {
    return [self friendNeedGroups:YES];
}

+(Friend*) friendNeedGroups:(BOOL)needGroups {
    Friend* friend = [[Friend alloc] init];
    
    friend.id = [self randomIdWithType:IdTypeUser];
    friend.avatarInfo = [self avatarInfo];
    
    if (needGroups) {
        int numGroups = RandomInt(5) + 1;
        for (int i=0; i < numGroups; ++i) {
            [friend.groups addObject:[self groupNeedId:YES needFriends:NO]];
        }
    }
    
    return friend;
}

@end
