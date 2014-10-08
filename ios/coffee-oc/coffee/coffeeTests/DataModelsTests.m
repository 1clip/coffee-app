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
#import "CoffeeTestCase.h"
#import "DataModels.h"

@interface DataModelsTests : CoffeeTestCase

@end

@implementation DataModelsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUserModel {
    User* user = [TestDataGenerator userWithPrefix:@"tom_slick" needId:YES];

    NSString* jsonString = [user toJSONString];
    NSLog(@"%@", jsonString);
    
    JSONModelError* error = nil;
    User* userFromJson = [[User alloc] initWithString:jsonString error:&error];
    
    EXP_expect(userFromJson).notTo.beNil();
    EXP_expect(userFromJson.id).to.equal(user.id);
    EXP_expect(userFromJson.loginName).to.equal(user.loginName);
    EXP_expect(userFromJson.friendlyName).to.equal(user.friendlyName);
    EXP_expect(userFromJson.locale).to.equal(user.locale);
    EXP_expect(userFromJson.gender).to.equal(user.gender);
    EXP_expect(userFromJson.birth).to.equal(user.birth);
    EXP_expect(userFromJson.cellPhone).to.equal(user.cellPhone);
    EXP_expect(userFromJson.signUpSource).to.equal(user.signUpSource);
    EXP_expect(userFromJson.avatarInfo).notTo.beNil();
    EXP_expect(userFromJson.avatarInfo.id).to.equal(user.avatarInfo.id);
    EXP_expect(userFromJson.avatarInfo.token).to.equal(user.avatarInfo.token);
}

- (void)testHangoutModel {
    Hangout* hangout = [TestDataGenerator hangoutNeedId:YES];
    
    NSString* jsongString = [hangout toJSONString];
    NSLog(@"%@", jsongString);
    
    JSONModelError* error = nil;
    Hangout* hangoutFromJson = [[Hangout alloc] initWithString:jsongString error:&error];
    
    EXP_expect(hangoutFromJson).notTo.beNil();
    EXP_expect(hangoutFromJson.activity).to.equal(hangout.activity);
    EXP_expect(hangoutFromJson.subject).to.equal(hangout.subject);
    EXP_expect(hangoutFromJson.location).to.equal(hangout.location);
    EXP_expect([hangoutFromJson.startTime compare:hangout.startTime]).to.equal(NSOrderedSame);
    EXP_expect([hangoutFromJson.endTime compare:hangout.endTime]).to.equal(NSOrderedSame);
    EXP_expect(hangoutFromJson.participators).notTo.beNil();
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
    Group* group = [TestDataGenerator groupNeedId:YES];
    
    NSString* jsonString = [group toJSONString];
    NSLog(@"%@", jsonString);
    
    JSONModelError* error = nil;
    Group* groupFromJson = [[Group alloc] initWithString:jsonString error:&error];
    
    EXP_expect(groupFromJson).notTo.beNil();
    EXP_expect(groupFromJson.id).to.equal(group.id);
    EXP_expect(groupFromJson.name).to.equal(group.name);
    EXP_expect(groupFromJson.friends).notTo.beNil();
    EXP_expect(groupFromJson.friends.count).to.equal(group.friends.count);
    for (int i=0; i<group.friends.count; ++i) {
        EXP_expect(((Friend*)groupFromJson.friends[i]).id).to.equal(((Friend*)group.friends[i]).id);
        EXP_expect(((Friend*)groupFromJson.friends[i]).avatarInfo.id).to.equal(((Friend*)group.friends[i]).avatarInfo.id);
        EXP_expect(((Friend*)groupFromJson.friends[i]).avatarInfo.token).to.equal(((Friend*)group.friends[i]).avatarInfo.token);
    }
}

- (void)testFriendModel {
    Friend* friend = [TestDataGenerator friendNeedGroups:YES];
    
    NSString* jsonString = [friend toJSONString];
    NSLog(@"%@", jsonString);
    
    JSONModelError* error = nil;
    Friend* friendFromJson = [[Friend alloc] initWithString:jsonString error:&error];
    EXP_expect(friendFromJson).notTo.beNil();
    EXP_expect(friendFromJson.id).to.equal(friend.id);
    EXP_expect(friendFromJson.friendlyName).to.equal(friend.friendlyName);
    EXP_expect(friendFromJson.avatarInfo).notTo.beNil();
    EXP_expect(friendFromJson.avatarInfo.id).to.equal(friend.avatarInfo.id);
    EXP_expect(friendFromJson.avatarInfo.token).to.equal(friend.avatarInfo.token);
    EXP_expect(friendFromJson.groups).notTo.beNil();
    EXP_expect(friendFromJson.groups.count).to.equal(friend.groups.count);
    for (int i=0; i<friend.groups.count; ++i) {
        EXP_expect(((Group*)friendFromJson.groups[i]).id).to.equal(((Group*)friend.groups[i]).id);
        EXP_expect(((Group*)friendFromJson.groups[i]).name).to.equal(((Group*)friend.groups[i]).name);
    }

}
@end
