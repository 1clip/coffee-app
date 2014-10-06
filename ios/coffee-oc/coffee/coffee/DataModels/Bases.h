//
//  Bases.h
//  coffee
//
//  Created by achiel on 14-10-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel/JSONModel.h"

@interface IdObject : JSONModel

@property (strong, nonatomic) NSString* id;

+(JSONKeyMapper*) keyMapper;

@end

@interface AvatarInfo : IdObject

@property (strong, nonatomic) NSString* token;

@end

@interface Character : IdObject

@property (strong, nonatomic) NSString<Optional>* friendlyName;

@property (strong, nonatomic) AvatarInfo<Optional>* avatarInfo;

@end

