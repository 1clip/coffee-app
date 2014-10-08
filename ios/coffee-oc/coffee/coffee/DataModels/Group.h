//
//  Group.h
//  coffee
//
//  Created by achiel on 14-10-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "Bases.h"

@protocol Group;
@protocol Friend;

@interface Group : IdObject

@property (strong, nonatomic) NSString* name;

@property (strong, nonatomic) NSMutableArray<Friend, Optional>* friends;

@end

@interface Friend : Character

@property (strong, nonatomic) NSMutableArray<Group, Optional>* groups;

@end
