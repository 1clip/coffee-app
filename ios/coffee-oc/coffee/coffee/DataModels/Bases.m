//
//  Bases.m
//  coffee
//
//  Created by achiel on 14-10-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "Bases.h"

@implementation IdObject

+(JSONKeyMapper*) keyMapper
{
    return [JSONKeyMapper mapperFromUnderscoreCaseToCamelCase];
}

@end

@implementation AvatarInfo

@end

@implementation Character

@end