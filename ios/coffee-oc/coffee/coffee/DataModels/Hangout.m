//
//  Hangout.m
//  coffee
//
//  Created by achiel on 14-10-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "Hangout.h"

@implementation Participator

@end

@implementation Hangout

-(NSMutableArray<Participator, Optional>*) participators {
    if (!_participators) {
        _participators = (NSMutableArray<Participator, Optional>*)[NSMutableArray array];
    }
    
    return _participators;
}

@end

@implementation HangoutSummary

@end