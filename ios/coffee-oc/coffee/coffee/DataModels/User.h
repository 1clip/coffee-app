//
//  User.h
//  coffee
//
//  Created by achiel on 14-10-6.
//  Copyright (c) 2014年 1clip. All rights reserved.
//

#import "Bases.h"

@interface User : Character

@property (strong, nonatomic) NSString<Optional>* loginName;

@property (strong, nonatomic) NSString<Optional>* gender;

@property (strong, nonatomic) NSString<Optional>* birth;

@property (strong, nonatomic) NSString<Optional>* locale;

@property (strong, nonatomic) NSString<Optional>* cellPhone;

@property (strong, nonatomic) NSString<Optional>* signUpSource;

@end
