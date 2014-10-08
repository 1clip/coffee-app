//
//  Group.m
//  coffee
//
//  Created by achiel on 14-10-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "Group.h"

@implementation Group

-(NSMutableArray<Friend, Optional>*) friends {
    if (!_friends) {
        _friends = (NSMutableArray<Friend, Optional>*)[NSMutableArray array];
    }
    
    return _friends;
}

@end

@implementation Friend

-(NSMutableArray<Group, Optional>*) groups {
    if (!_groups) {
        _groups = (NSMutableArray<Group, Optional>*)[NSMutableArray array];
    }
    
    return _groups;
}

@end
