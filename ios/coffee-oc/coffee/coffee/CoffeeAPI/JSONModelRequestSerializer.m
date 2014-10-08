//
//  JSONModelRequestSerializer.m
//  coffee
//
//  Created by achiel on 14-10-8.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "JSONModelRequestSerializer.h"
#import "CoffeeAPI.h"

@implementation JSONModelRequestSerializer

+ (instancetype)serializer {
    return [[self alloc] init];
}

#pragma mark - AFURLRequestSerialization

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(request);
    
    if ([self.HTTPMethodsEncodingParametersInURI containsObject:[[request HTTPMethod] uppercaseString]]) {
        return [super requestBySerializingRequest:request withParameters:parameters error:error];
    }
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![request valueForHTTPHeaderField:field]) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
    
    IdObject* currentUserId = [CoffeeAPI currentUserId];
    if (currentUserId && currentUserId.id) {
        [mutableRequest setValue:[NSString stringWithFormat:@"%ld", currentUserId.id] forHTTPHeaderField:@"user-id"];
    }
    
    if (parameters) {
        if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
            NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
            [mutableRequest setValue:[NSString stringWithFormat:@"application/json; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
        }
        
        if ([parameters isKindOfClass:[JSONModel class]]) {
            NSData* data = [[parameters performSelector:@selector(toJSONString)] dataUsingEncoding:NSUTF8StringEncoding];
            [mutableRequest setHTTPBody:data];
        }
        else {
            [mutableRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:self.writingOptions error:error]];
        }
    }
    
    return mutableRequest;
}

@end
