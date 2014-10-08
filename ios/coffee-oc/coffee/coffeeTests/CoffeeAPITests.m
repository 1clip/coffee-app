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
    // This is an example of a functional test case.
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
}

- (void)testPostHangout {
    
    __block User* user = nil;
    __block NSError* error = nil;
    NSURLSessionDataTask* task = [self.coffeeAPI createUser:[TestDataGenerator userWithPrefix:@"foo_bar"]
                                          completionHandler:^(User* response, NSError* err) {
                                              user = response;
                                              error = err;
                                          }];
    
    EXP_expect(task.state).will.equal(NSURLSessionTaskStateCompleted);
    EXP_expect([CoffeeAPI currentUserId]).notTo.beNil();
    
    Hangout* testHangout = [TestDataGenerator hangoutNeedId:NO];
    __block Hangout* hangout = nil;
    task = [self.coffeeAPI createHangout:testHangout
                       completionHandler:^(Hangout* response, NSError* err) {
                           hangout = response;
                           error = err;
                       }];
    
    EXP_expect(task.state).will.equal(NSURLSessionTaskStateCompleted);
    EXP_expect(hangout.id).notTo.equal(0);
    EXP_expect(hangout.subject).to.equal(testHangout.subject);
}

@end
