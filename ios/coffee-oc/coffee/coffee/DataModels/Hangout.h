//
//  Hangout.h
//  coffee
//
//  Created by achiel on 14-10-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "Bases.h"

@protocol Participator;
@interface Participator : Character

@property (strong, nonatomic) NSString<Optional>* role;

@property (strong, nonatomic) NSString<Optional>* state;

@property (assign, nonatomic) NSNumber<Optional>* errorCode;

@end

@interface Hangout : IdObject

@property (strong, nonatomic) NSString* activity;

@property (strong, nonatomic) NSString<Optional>* subject;

@property (strong, nonatomic) NSString* location;

@property (strong, nonatomic) NSDate* startTime;

@property (strong, nonatomic) NSDate* endTime;

@property (strong, nonatomic) NSMutableArray<Participator, Optional>* participators;

@end


@protocol HangoutSummary;
@interface HangoutSummary : IdObject
    
@property (strong, nonatomic) NSString* activity;
    
@property (strong, nonatomic) NSString<Optional>* subject;
    
@property (strong, nonatomic) NSString<Optional>* state;
    
@property (strong, nonatomic) Participator* organizer;
    
@property (assign, nonatomic) NSInteger numAccepted;
    
@property (assign, nonatomic) NSInteger numRejected;
    
@property (assign, nonatomic) NSInteger numPending;

@end
