//
//  FakeData.h
//  coffee
//
//  Created by wang xuan on 14/12/16.
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

@interface FakeData : NSObject

@property (strong, nonatomic) NSMutableArray<HangoutSummary>* hangoutSummaryList;
@property (strong, nonatomic) NSMutableDictionary* hangoutList;
@property (strong, nonatomic) NSMutableArray* userList;
@property (strong, nonatomic) User* currentUser;

-(void) InitFakeData;

-(Hangout*) GetHanogoutById: (long) hangoutid;

-(NSMutableArray<HangoutSummary> *) GetHangoutSummary :(NSString *) state;

-(HangoutSummary*) GetHangoutSummaryById :(long) hangoutid;

-(User *)GetCurrentUser;

-(User *) GetUserById: (long) userId;

-(Hangout*) GetFakeHangout;

-(Hangout *)CreateHangout:(Hangout*) hangout Organizer:(User*) organizer;
@end
