//
//  HangoutHelper.h
//  coffee
//
//  Created by wang xuan on 14/12/16.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"
#import "FakeData.h"

@interface HangoutHelper : NSObject

+(Participator*) FindParticipatorByUserId:(Hangout *) hangout UserId: (long) userId;

-(NSMutableArray<HangoutSummary>*) GetActiveHangoutSummary;
-(NSMutableArray<HangoutSummary>*) GetOverdueHangoutSummary;
-(Hangout*) GetHangoutDetails:(long) hangoutid;
-(HangoutSummary*) GetHangoutSummaryById :(long) hangoutid;
-(User*) GetCurrentUser;
-(User*) GetUserById:(long) userId;

-(Hangout *)CreateHangout:(Hangout*) hangout Organizer:(User*) organizer;

@end
