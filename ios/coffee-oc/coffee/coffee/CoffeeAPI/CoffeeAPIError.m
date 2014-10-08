//
//  CoffeeAPIError.m
//  coffee
//
//  Created by achiel on 14-10-9.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "CoffeeAPIError.h"

NSString* const CoffeeAPIErrorDomain = @"CoffeeAPIErrorDomain";

@implementation CoffeeAPIError

+(instancetype) errorServerErrorWithMessage:(NSString *)message
{
    return [self errorWithDomain:CoffeeAPIErrorDomain
                            code:cfAPI_ServerError
                        userInfo:@{NSLocalizedDescriptionKey:message}];
}

+(instancetype) errorTimeout
{
    return [self errorWithDomain:CoffeeAPIErrorDomain
                            code:cfAPI_Timeout
                        userInfo:nil];
}

+(instancetype) errorInvalidResponse
{
    return [self errorWithDomain:CoffeeAPIErrorDomain
                            code:cfAPI_InvalidResponse
                        userInfo:nil];
}

@end
