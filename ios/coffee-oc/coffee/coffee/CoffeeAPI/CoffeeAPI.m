//
//  CoffeeAPI.m
//  coffee
//
//  Created by achiel on 14-10-9.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "CoffeeAPI.h"
#import "JSONModelRequestSerializer.h"

@implementation CoffeeAPI

+(instancetype) coffeeAPIWithBaseUrl:(NSURL *)baseUrl
{
    CoffeeAPI* instance = [[self alloc] init];
    instance.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
    instance.sessionManager.requestSerializer = [JSONModelRequestSerializer serializer];
    
    return instance;
}

-(NSURL*) baseUrl
{
    return self.sessionManager.baseURL;
}

#pragma mark - API

-(NSURLSessionDataTask*) createUser:(User*)user
                  completionHandler:(void (^)(User *response, NSError *error))completionHandler
{
    return [self.sessionManager POST:@"users"
                          parameters:user
                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                 User* response;
                                 JSONModelError* modelError;
                                 response = [[User alloc] initWithDictionary:(NSDictionary *)responseObject error:&modelError];
                                 
                                 if (modelError) {
                                     completionHandler(nil, modelError);
                                 }
                                 else {
                                     [CoffeeAPI setCurrentUserId:[IdObject idWithValue:response.id]];
                                     completionHandler(response, nil);
                                 }
                             }
                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                 completionHandler(nil, error);
                             }];
}

-(NSURLSessionDataTask*) getUser:(IdObject*)idObject
               completionHandler:(void (^)(User *response, NSError *error))completionHandler
{
    return [self.sessionManager GET:[NSString stringWithFormat:@"users/%ld", idObject.id]
                          parameters:nil
                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                 User* response;
                                 JSONModelError* modelError;
                                 response = [[User alloc] initWithDictionary:(NSDictionary *)responseObject error:&modelError];
                                 
                                 if (modelError) {
                                     completionHandler(nil, modelError);
                                 }
                                 else {
                                     completionHandler(response, nil);
                                 }
                             }
                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                 completionHandler(nil, error);
                             }];
}

-(NSURLSessionDataTask*) createHangout:(Hangout*)hangout
                     completionHandler:(void (^)(Hangout *response, NSError *error))completionHandler
{
    return [self.sessionManager POST:@"hangouts"
                         parameters:hangout
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                Hangout* response;
                                JSONModelError* modelError;
                                response = [[Hangout alloc] initWithDictionary:(NSDictionary *)responseObject error:&modelError];
                                
                                if (modelError) {
                                    completionHandler(nil, modelError);
                                }
                                else {
                                    completionHandler(response, nil);
                                }
                            }
                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                completionHandler(nil, error);
                            }];
}

-(NSURLSessionDataTask*) getHangout:(IdObject*)idObject
                  completionHandler:(void (^)(Hangout *response, NSError *error))completionHandler
{
    return [self.sessionManager GET:[NSString stringWithFormat:@"users/%ld", idObject.id]
                          parameters:nil
                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                 Hangout* response;
                                 JSONModelError* modelError;
                                 response = [[Hangout alloc] initWithDictionary:(NSDictionary *)responseObject error:&modelError];
                                 
                                 if (modelError) {
                                     completionHandler(nil, modelError);
                                 }
                                 else {
                                     completionHandler(response, nil);
                                 }
                             }
                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                 completionHandler(nil, error);
                             }];
}

-(NSURLSessionDataTask*) getActiveHangoutSummaries:(void (^)(NSArray<HangoutSummary> *response, NSError *error))completionHandler
{
    return [self.sessionManager GET:@"hangouts?state=active"
                         parameters:nil
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                NSMutableArray<HangoutSummary>* response = (NSMutableArray<HangoutSummary>*) [NSMutableArray array];
                                JSONModelError* modelError = nil;
                                
                                if (responseObject) {
                                    NSArray* responseArray = (NSArray*)responseObject;
                                    for (int i=0; i<responseArray.count; ++i) {
                                        HangoutSummary* hangoutSummary = [[HangoutSummary alloc] initWithDictionary:(NSDictionary *)responseArray[i] error:&modelError];
                                        if (modelError) {
                                            break;
                                        }
                                        [response addObject:hangoutSummary];
                                    }
                                }
                                
                                if (modelError) {
                                    completionHandler(nil, modelError);
                                }
                                else {
                                    completionHandler(response, nil);
                                }
                            }
                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                completionHandler(nil, error);
                            }];
}

static IdObject* _currentUserId = nil;
+(IdObject*) currentUserId
{
    return _currentUserId;
}

+(void) setCurrentUserId:(IdObject *)userId
{
    _currentUserId = userId;
}

@end
