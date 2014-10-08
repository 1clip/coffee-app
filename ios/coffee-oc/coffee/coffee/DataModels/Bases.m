//
//  Bases.m
//  coffee
//
//  Created by achiel on 14-10-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "Bases.h"

@implementation IdObject

+(instancetype) idWithValue:(long) id
{
    IdObject* instance = [[IdObject alloc] init];
    instance.id = id;
    
    return instance;
}

+(JSONKeyMapper*) keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end

@implementation AvatarInfo

@end

@implementation Character

@end