//
//  coffeeClientTests.m
//  coffee
//
//  Created by achiel on 14-10-7.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoffeeTestCase.h"
#import "CoffeeAPI.h"

@interface CoffeeAPITests : CoffeeTestCase
@property (strong, nonatomic) CoffeeAPI* coffeeAPI;
@end

@implementation CoffeeAPITests

- (void)setUp {
    [super setUp];

    self.coffeeAPI = [CoffeeAPI coffeeAPIWithBaseUrl:[NSURL URLWithString:@"http://localhost:8080/v1"]];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPostUser {
    
    User* postedUser;
    
    [self postUser:&postedUser];
}

- (void)testPostHangout {
    
    User* orgnizer;
    [self postUser:&orgnizer];
    
    Hangout* hangout;
    [self postHangout:&hangout withOrgnizer:orgnizer];
}

- (void)testGetHangoutSummary {
    
    User* orgnizer;
    [self postUser:&orgnizer];
    
    NSInteger numHangouts = 2;
    Hangout* hangout;
    for (int i=0; i<numHangouts; ++i) {
        [self postHangout:&hangout withOrgnizer:orgnizer];
    }

    __block NSArray<HangoutSummary>* hangoutSummaries;
    __block NSError* error;
    NSURLSessionDataTask* task = [self.coffeeAPI getActiveHangoutSummaries:^(NSArray<HangoutSummary> *response, NSError *error) {
        hangoutSummaries = response;
        error = error;
    }];
    
    EXP_expect(task.state).will.equal(NSURLSessionTaskStateCompleted);
    EXP_expect(error).to.beNil();
    EXP_expect(hangoutSummaries.count).to.equal(numHangouts);
}

#pragma mark - Post test models

- (void)postUser:(User**)postedUser {
    
    User* testUser = [TestDataGenerator userWithPrefix:@"foo_bar"];
    
    __block User* user = nil;
    __block NSError* error = nil;
    NSURLSessionDataTask* task = [self.coffeeAPI createUser:testUser
                                          completionHandler:^(User* response, NSError* err) {
                                              user = response;
                                              error = err;
                                          }];
    
    EXP_expect(task.state).will.equal(NSURLSessionTaskStateCompleted);
    EXP_expect(error).to.beNil();
    EXP_expect(user).notTo.beNil();
    EXP_expect(user.id).notTo.equal(0);
    EXP_expect(user.loginName).to.equal(testUser.loginName);
    
    *postedUser = user;
}

- (void)postHangout:(Hangout**) postedHangout
           withOrgnizer:(User*)orgnizer {

    Hangout* testHangout = [TestDataGenerator hangoutNeedId:NO];
    User* participator = nil;
    for (int i=0; i < testHangout.participators.count; ++i) {
        [self postUser:&participator];
        ((IdObject*) testHangout.participators[i]).id = participator.id;
    }
    
    [CoffeeAPI setCurrentUserId:[IdObject idWithValue:orgnizer.id]];
    __block Hangout* hangout = nil;
    __block NSError* error = nil;
    NSURLSessionDataTask* task = [self.coffeeAPI createHangout:testHangout
                       completionHandler:^(Hangout* response, NSError* err) {
                           hangout = response;
                           error = err;
                       }];
    
    EXP_expect(task.state).will.equal(NSURLSessionTaskStateCompleted);
    EXP_expect(hangout.id).notTo.equal(0);
    EXP_expect(hangout.activity).to.equal(testHangout.activity);
    EXP_expect(hangout.subject).to.equal(testHangout.subject);
    EXP_expect(hangout.location).to.equal(testHangout.location);
    EXP_expect(hangout.startTime).to.equal(testHangout.startTime);
    EXP_expect(hangout.endTime).to.equal(testHangout.endTime);
    EXP_expect(hangout.participators.count).to.equal(testHangout.participators.count);
    
    *postedHangout = hangout;
}

@end
