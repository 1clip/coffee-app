//
//  User.swift
//  coffee
//
//  Created by achiel on 14-10-4.
//  Copyright (c) 2014年 1Clip. All rights reserved.
//


public class User : Character {

    public var loginName: NSString!
    
    public var gender: NSString!
    
    public var birth: NSString!
    
    public var locale: NSString!
    
    public var cellPhone: NSString!
    
    public var signUpSource: NSString!
    
    public override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}