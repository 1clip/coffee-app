//
//  Location.m
//  coffee
//
//  Created by wang xuan on 14-12-3.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "Placeholder.h"

@implementation Location

@end

@implementation SearchLocation

-(NSMutableArray<Location, Optional>*) locations {
    if (!_locations) {
        _locations = (NSMutableArray<Location, Optional>*)[NSMutableArray array];
    }
    
    return _locations;
}
@end

@implementation PlaceholderUser

@end
