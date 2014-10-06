//
//  coffeeTests.m
//  coffeeTests
//
//  Created by achiel on 14-10-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Expecta.h"
#import "DataModels/DataModels.h"

@interface coffeeTests : XCTestCase

@end

@implementation coffeeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUserModel {
    User* user = [[User alloc] init];
    
    user.id = @"user_id_1";
    user.loginName = @"tom_slick";
    user.friendlyName = @"fiendlyName";
    user.locale = @"US";
    user.gender = Gender.Male;
    user.birth = @"1980-01-01";
    user.cellPhone = @"+1 (415) 123-456";
    user.signUpSource = @"cell_phone";
    
    user.avatarInfo = [[AvatarInfo alloc] init];
    user.avatarInfo.Id = @"my_avatart";
    user.avatarInfo.token = @"token";

    NSString* jsonString = [user toJSONString];
    NSLog(@"%@", jsonString);
    
    JSONModelError* error = nil;
    User* userFromJson = [[User alloc] initWithString:jsonString error:&error];
    
    EXP_expect(userFromJson).toNot.equal(nil);
    EXP_expect(userFromJson.id).to.equal(user.id);
    EXP_expect(userFromJson.loginName).to.equal(user.loginName);
    EXP_expect(userFromJson.friendlyName).to.equal(user.friendlyName);
    EXP_expect(userFromJson.locale).to.equal(user.locale);
    EXP_expect(userFromJson.gender).to.equal(user.gender);
    EXP_expect(userFromJson.birth).to.equal(user.birth);
    EXP_expect(userFromJson.cellPhone).to.equal(user.cellPhone);
    EXP_expect(userFromJson.signUpSource).to.equal(user.signUpSource);
    EXP_expect(userFromJson.avatarInfo).toNot.equal(nil);
    EXP_expect(userFromJson.avatarInfo.id).to.equal(user.avatarInfo.id);
    EXP_expect(userFromJson.avatarInfo.token).to.equal(user.avatarInfo.token);
}

- (void)testHangoutModel {
    Hangout* hangout = [[Hangout alloc] init];
    
    hangout.id = @"";
    hangout.activity = @"Dinner";
    hangout.subject = @"Birthday";
    hangout.location = @"Pie Street 123, San Francisco, CS";
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    now -= fmod(now, 1);
    hangout.startTime = [NSDate dateWithTimeIntervalSince1970:now];
    hangout.endTime = [hangout.startTime dateByAddingTimeInterval: 7200];
    hangout.participators = [[NSMutableArray alloc] init];
    
    Participator* participator = [[Participator alloc] init];
    participator.id = @"participator_id_1";
    participator.role = ParticipatorRole.Invitee;
    [hangout.participators addObject:participator];
    
    participator = [[Participator alloc] init];
    participator.id = @"participator_id_2";
    participator.role = ParticipatorRole.Organizer;
    [hangout.participators addObject:participator];
    
    NSString* jsongString = [hangout toJSONString];
    NSLog(@"%@", jsongString);
    
    JSONModelError* error = nil;
    Hangout* hangoutFromJson = [[Hangout alloc] initWithString:jsongString error:&error];
    
    EXP_expect(hangoutFromJson).toNot.equal(nil);
    EXP_expect(hangoutFromJson.activity).to.equal(hangout.activity);
    EXP_expect(hangoutFromJson.subject).to.equal(hangout.subject);
    EXP_expect(hangoutFromJson.location).to.equal(hangout.location);
    EXP_expect([hangoutFromJson.startTime compare:hangout.startTime]).to.equal(NSOrderedSame);
    EXP_expect([hangoutFromJson.endTime compare:hangout.endTime]).to.equal(NSOrderedSame);
    EXP_expect(hangoutFromJson.participators).toNot.equal(nil);
    EXP_expect(hangoutFromJson.participators.count).to.equal(hangout.participators.count);
    for (int i=0; i < hangoutFromJson.participators.count; ++i) {
        EXP_expect(((Participator*) hangoutFromJson.participators[i]).id)
            .to
            .equal(((Participator*)hangout.participators[i]).id);
        EXP_expect(((Participator*) hangoutFromJson.participators[i]).role)
            .to
            .equal(((Participator*)hangout.participators[i]).role);
    }
}

- (void)testGroupModel {
    Group* group = [[Group alloc] init];
    
    group.id = @"group_id";
    group.name = @"Colleagues";
    group.friends = [[NSMutableArray alloc] init];
    
    Friend* friend = [[Friend alloc] init];
    friend.id = @"friend_id_1";
    friend.avatarInfo = [[AvatarInfo alloc] init];
    friend.avatarInfo.id = @"avatar_id";
    friend.avatarInfo.token = @"token";
    [group.friends addObject:friend];
    
    NSString* jsonString = [group toJSONString];
    NSLog(@"%@", jsonString);
    
    JSONModelError* error = nil;
    Group* groupFromJson = [[Group alloc] initWithString:jsonString error:&error];
    
    EXP_expect(groupFromJson).toNot.equal(nil);
    EXP_expect(groupFromJson.id).to.equal(group.id);
    EXP_expect(groupFromJson.name).to.equal(group.name);
    EXP_expect(groupFromJson.friends).toNot.equal(nil);
    EXP_expect(groupFromJson.friends.count).to.equal(group.friends.count);
    for (int i=0; i<group.friends.count; ++i) {
        EXP_expect(((Friend*)groupFromJson.friends[i]).id).to.equal(((Friend*)group.friends[i]).id);
        EXP_expect(((Friend*)groupFromJson.friends[i]).avatarInfo.id).to.equal(((Friend*)group.friends[i]).avatarInfo.id);
        EXP_expect(((Friend*)groupFromJson.friends[i]).avatarInfo.token).to.equal(((Friend*)group.friends[i]).avatarInfo.token);
    }
}

- (void)testFriendModel {
    Friend* friend = [[Friend alloc] init];
    
    friend.id = @"friend_id";
    friend.friendlyName = @"friendly_name";
    friend.avatarInfo = [[AvatarInfo alloc] init];
    friend.avatarInfo.id = @"avatar_id";
    friend.avatarInfo.token = @"token";
    
    friend.groups = [[NSMutableArray alloc] init];
    Group* group = [[Group alloc] init];
    group.id = @"group_id";
    group.name = @"group_name";
    [friend.groups addObject:group];
    
    NSString* jsonString = [friend toJSONString];
    NSLog(@"%@", jsonString);
    
    JSONModelError* error = nil;
    Friend* friendFromJson = [[Friend alloc] initWithString:jsonString error:&error];
    EXP_expect(friendFromJson).toNot.equal(nil);
    EXP_expect(friendFromJson.id).to.equal(friend.id);
    EXP_expect(friendFromJson.friendlyName).to.equal(friend.friendlyName);
    EXP_expect(friendFromJson.avatarInfo).toNot.equal(nil);
    EXP_expect(friendFromJson.avatarInfo.id).to.equal(friend.avatarInfo.id);
    EXP_expect(friendFromJson.avatarInfo.token).to.equal(friend.avatarInfo.token);
    EXP_expect(friendFromJson.groups).toNot.equal(nil);
    EXP_expect(friendFromJson.groups.count).to.equal(friend.groups.count);
    for (int i=0; i<friend.groups.count; ++i) {
        EXP_expect(((Group*)friendFromJson.groups[i]).id).to.equal(((Group*)friend.groups[i]).id);
        EXP_expect(((Group*)friendFromJson.groups[i]).name).to.equal(((Group*)friend.groups[i]).name);
    }

}
@end
