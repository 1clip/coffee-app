//
//  FakeData.m
//  coffee
//
//  Created by wang xuan on 14/12/16.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "FakeData.h"
@implementation FakeData

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

-(long) randomIdWithType:(IdType)idType {
    long timeTick = [NSDate timeIntervalSinceReferenceDate] * 1000;
    int workerId = arc4random_uniform(maxWorkerId);
    int sequenceId = arc4random_uniform(maxSequenceId);
    
    return (long)idType << idTypeShift |
    timeTick << timestampLeftShift |
    workerId << workerIdShift |
    sequenceId;
}

- (AvatarInfo*) avatarInfo: (NSString *)imageUrl {
    AvatarInfo* avatarInfo = [[AvatarInfo alloc] init];
    avatarInfo.id = [self randomIdWithType:IdTypeAvatar];
    avatarInfo.token = avatarInfo.id;
    avatarInfo.imageUrl = imageUrl;
    return avatarInfo;
}

#pragma mark User
-(User*) user {
    return [self userWithPrefix:@"tom_slick"];
}

-(User*) userWithPrefix:(NSString*)lNamePrefix {
    return [self userWithPrefix:lNamePrefix needId:NO AvatorImage:nil];
}

-(User*) userWithPrefix:(NSString *)lNamePrefix needId:(BOOL)needId AvatorImage:(NSString *)imageUrl {
    User* user = [[User alloc] init];
    
    if (needId) {
        user.id = [self randomIdWithType:IdTypeUser];
    }
    user.loginName = [NSString stringWithFormat:@"%@", lNamePrefix];
    user.friendlyName = [NSString stringWithFormat:@"%@", user.loginName];
    user.locale = @"US";
    user.gender = RandomInt(2) == 0 ? [Gender Male] : [Gender Female];
    user.birth = @"1980-01-01";
    user.cellPhone = @"+1 (415) 123-456";
    user.signUpSource = @"cell_phone";
    user.avatarInfo = [self avatarInfo: imageUrl];
    
    return user;
}


-(Hangout*) hangoutNeedId:(BOOL)needId {
    return [self hangoutWithOId:[self randomIdWithType:IdTypeUser] needId:needId];
}

-(Hangout*) hangoutWithOId:(long)organizerId {
    return [self hangoutWithOId:organizerId needId:NO];
}

-(Hangout*) hangoutWithOId:(long)organizerId needId:(BOOL)needId {
    Hangout* hangout = [[Hangout alloc] init];
    
    if (needId) {
        hangout.id = [self randomIdWithType:IdTypeHangout];
    }
    hangout.subject = @"Today is my birthday!";
    hangout.location = @"123 Pie Street, San Francisco, CS";
    
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    now -= fmod(now, 1);
    hangout.startTime = [NSDate dateWithTimeIntervalSince1970:now];
    hangout.endTime = [hangout.startTime dateByAddingTimeInterval: RandomInt(10000) + 1000];
    
    int numParticipator = RandomInt(5) + 1;
    NSMutableArray* array = [NSMutableArray arrayWithObjects:
                                                                  [NSNumber numberWithInt:0],
                                                                  [NSNumber numberWithInt:1],
                                                                  [NSNumber numberWithInt:2],
                                                                  [NSNumber numberWithInt:3],
                                                                  [NSNumber numberWithInt:4],
                                                                  nil];
    int count = (int)array.count;
    for(int i = 0; i < 10; i++)
    {
        int a = RandomInt(count);
        int b = RandomInt(count);
        [array exchangeObjectAtIndex:a withObjectAtIndex:b];
    }
    int currentUserIndex = RandomInt(numParticipator);
    for (int i = 0; i < numParticipator; ++i) {
        NSString *state;
        switch (RandomInt(3)) {
            case 0:
                state = [ParticipatorState Accept];
                break;
            case 1:
                state = [ParticipatorState Pending];
                break;
            case 2:
                state = [ParticipatorState Reject];
                break;
        }
        if(i == currentUserIndex)
        {
            [hangout.participators addObject:[self participator:self.currentUser RoleForHangout:i == 0 ? [ParticipatorRole Organizer] : [ParticipatorRole Invitee] State:state]];
        }
        else
        {
            User * user = self.userList[((NSNumber*)array[i]).intValue];
            
            [hangout.participators addObject:[self participator:user RoleForHangout:i == 0 && i != currentUserIndex ? [ParticipatorRole Organizer] : [ParticipatorRole Invitee] State:state]];
        }
        
    }
    return hangout;
}

-(Participator*) participator :(User *) user RoleForHangout:(NSString *) role State:(NSString *) state{
    Participator* participator = [[Participator alloc] init];
    participator.id = user.id;
    participator.role = role;
    participator.state = state;
    participator.friendlyName = user.friendlyName;
    participator.avatarInfo = user.avatarInfo;
    return participator;
}

-(void) InitUser
{
    self.currentUser = [self userWithPrefix:@"奥迪哥" needId:YES AvatorImage:@"Sample_Audi.jpg"];
    self.userList = [[NSMutableArray alloc] init];
    for(int i = 0; i < 5; i++)
    {
        NSString *userName;
        NSString *avator;
        switch (i) {
            case 0:
                avator = @"xiaowu";
                userName = @"吴母牛";
                break;
            case 1:
                avator = @"Sample_Achie.jpg";
                userName = @"阿屌丝";
                break;
            case 2:
                avator = @"Sample_Glass.jpg";
                userName = @"So姐姐";
                break;
            case 3:
                avator = @"Sample_Rae.jpg";
                userName = @"瑞娥";
                break;
            case 4:
                avator = @"Sample_Sofang.jpg";
                userName = @"方圆";
                break;
        }
        User *user = [self userWithPrefix:userName needId:YES AvatorImage:avator];
        [self.userList addObject:user];
    }
}

-(void) InitHangout
{
    for(int i = 0; i < 6; i++)
    {
        Hangout *hangout = [self hangoutNeedId:YES];
        switch (i) {
            case 0:
                hangout.activity = @"Activity_Dinner";
                break;
            case 1:
                hangout.activity = @"Activity_Coffee";
                break;
            case 2:
                hangout.activity = @"Activity_Shower";
                break;
            case 3:
                hangout.activity = @"Activity_KTV";
                break;
            case 4:
                hangout.activity = @"Activity_Movie";
                break;
            case 5:
                hangout.activity = @"Activity_Shopping";
                break;
            default:
                break;
        }
        if(self.hangoutList == nil)
        {
            self.hangoutList = [[NSMutableDictionary alloc] init];
            self.hangoutSummaryList = (NSMutableArray<HangoutSummary>*)[NSMutableArray array];
        }
        [self.hangoutList setObject:hangout forKey:[NSString stringWithFormat:@"%ld", hangout.id]];
        
        NSString *state;
        if(i < 4)
        {
            state = [HangoutState Active];
        }
        else
        {
            state = [HangoutState Overdue];
        }
        HangoutSummary *hangoutSummary = [self CreateHangoutSummary:hangout StateForHangout:state];
        [self.hangoutSummaryList addObject:hangoutSummary];
    }
}

-(HangoutSummary *) CreateHangoutSummary: (Hangout *) hangout StateForHangout: (NSString *) state
{
    HangoutSummary *hangoutSummary = [[HangoutSummary alloc] init];
    hangoutSummary.state = state;
    hangoutSummary.id = hangout.id;
    hangoutSummary.activity = hangout.activity;
    hangoutSummary.subject = hangout.subject;
    hangoutSummary.numAccepted = hangoutSummary.numPending = hangoutSummary.numRejected = 0;
    for(Participator* participator in hangout.participators)
    {
        if(participator.state == [ParticipatorState Accept])
            hangoutSummary.numAccepted ++;
        else if(participator.state == [ParticipatorState Pending])
            hangoutSummary.numPending ++;
        else if(participator.state == [ParticipatorState Reject])
            hangoutSummary.numRejected++;
        if(participator.role == [ParticipatorRole Organizer])
        {
            hangoutSummary.organizer = participator;
        }
    }
    return hangoutSummary;
}

-(Hangout *) GetHanogoutById: (long) hangoutid;
{
    if(self.hangoutList != nil)
    {
        NSString* key = [NSString stringWithFormat:@"%ld", hangoutid];
        return [self.hangoutList objectForKey:key];
    }
    return nil;
}

-(NSMutableArray<HangoutSummary> *) GetHangoutSummary :(NSString *) state
{
    NSMutableArray<HangoutSummary> * res = (NSMutableArray<HangoutSummary>*)[NSMutableArray array];
    for(HangoutSummary *hangoutSummary in self.hangoutSummaryList)
    {
        if(hangoutSummary.state == state)
        {
            [res addObject:hangoutSummary];
        }
    }
    
    return res;
}

-(HangoutSummary*) GetHangoutSummaryById :(long) hangoutid
{    for(HangoutSummary *hangoutSummary in self.hangoutSummaryList)
    {
        if(hangoutSummary.id == hangoutid)
        {
            return hangoutSummary;
        }
    }
    
    return nil;
}

-(User *) GetUserById: (long) userId
{
    if(self.currentUser.id == userId) return self.currentUser;
    if(self.userList != nil)
    {
        for(User *user in self.userList)
        {
            if(user.id == userId)
                return user;
        }
    }
    return nil;
}


-(void) InitFakeData
{
    [self InitUser];
    [self InitHangout];
}

-(User *) GetCurrentUser
{
    return self.currentUser;
}


@end
