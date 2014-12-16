//
//  HangoutHelper.m
//  coffee
//
//  Created by wang xuan on 14/12/16.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "HangoutHelper.h"
#import "FakeData.h"

@implementation HangoutHelper

static FakeData *fakeData;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Initialization code
        if(fakeData == nil)
        {
            fakeData = [[FakeData alloc] init];
            [fakeData InitFakeData];
        }
    }
    return self;

}

+(Participator*) FindParticipatorByUserId:(Hangout *) hangout UserId: (long) userId
{
    if(hangout != nil && hangout.participators != nil && hangout.participators.count > 0)
    {
        for(Participator * par in hangout.participators)
        {
            if(par.id == userId)
            {
                return  par;
            }
        }
    }
    
    return nil;
}

-(NSMutableArray<HangoutSummary>*) GetActiveHangoutSummary
{
    return [fakeData GetHangoutSummary:[HangoutState Active]];
}

-(NSMutableArray<HangoutSummary>*) GetOverdueHangoutSummary
{
    return [fakeData GetHangoutSummary:[HangoutState Overdue]];
}

-(Hangout*) GetHangoutDetails:(long) hangoutid
{
    return [fakeData GetHanogoutById:hangoutid];
}

-(HangoutSummary*) GetHangoutSummaryById :(long) hangoutid
{
    return [fakeData GetHangoutSummaryById:hangoutid];
}

-(User *) GetCurrentUser
{
    return [fakeData GetCurrentUser];
}

-(User*) GetUserById:(long) userId
{
    return [fakeData GetUserById:userId];
}


@end
