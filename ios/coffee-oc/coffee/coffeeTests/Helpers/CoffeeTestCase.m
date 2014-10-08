//
//  CoffeeTestCase.m
//  coffee
//
//  Created by achiel on 14-10-7.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "CoffeeTestCase.h"

@implementation CoffeeTestCase

- (void)setUp {
    [super setUp];
    
    [Expecta setAsynchronousTestTimeout:5.0];
}

- (void)tearDown {
    [super tearDown];
}

@end
