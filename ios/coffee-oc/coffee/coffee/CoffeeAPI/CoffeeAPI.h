//
//  CoffeeAPI.h
//  coffee
//
//  Created by achiel on 14-10-9.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "DataModels.h"
#import "CoffeeAPIError.h"

@interface CoffeeAPI : NSObject

+(instancetype) coffeeAPIWithBaseUrl:(NSURL*) baseUrl;

@property (readonly, strong, nonatomic) NSURL* baseUrl;

-(NSURLSessionDataTask*) createUser:(User*)user
                  completionHandler:(void (^)(User *response, NSError *error))completionHandler;

-(NSURLSessionDataTask*) getUser:(IdObject*)idObject
               completionHandler:(void (^)(User *response, NSError *error))completionHandler;

-(NSURLSessionDataTask*) createHangout:(Hangout*)hangout
                     completionHandler:(void (^)(Hangout *response, NSError *error))completionHandler;

-(NSURLSessionDataTask*) getHangout:(IdObject*)idObject
                  completionHandler:(void (^)(Hangout *response, NSError *error))completionHandler;

-(NSURLSessionDataTask*) getActiveHangoutSummaries:(void (^)(NSArray<HangoutSummary> *response, NSError *error))completionHandler;

// Temperary HACK: for user-id header pass in;
+(IdObject*) currentUserId;
+(void) setCurrentUserId:(IdObject*)userId;

// Temperarily expose session manager.
@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;

@end
