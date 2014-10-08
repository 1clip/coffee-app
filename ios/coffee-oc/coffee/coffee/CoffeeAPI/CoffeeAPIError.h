//
//  CoffeeAPIError.h
//  coffee
//
//  Created by achiel on 14-10-9.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, cfAPIErrorCode) {
    cfAPI_ServerError = 1,
    cfAPI_Timeout = 2,
    cfAPI_InvalidResponse = 3,
};

@interface CoffeeAPIError : NSError

+(instancetype) errorServerErrorWithMessage:(NSString*)message;

+(instancetype) errorTimeout;

+(instancetype) errorInvalidResponse;

@end
