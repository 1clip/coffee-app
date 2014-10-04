//
//  Bases.swift
//  coffee
//
//  Created by achiel on 14-10-3.
//  Copyright (c) 2014年 1Clip. All rights reserved.
//

public class IdObject : JSONModel {
    public var id : NSString!
    
    public override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
    
}

public class AvatarInfo : IdObject {
    public var token : NSString!
    
    public override class func keyMapper() -> JSONKeyMapper {
        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase()
    }
}

public class Character : IdObject {

    public var friendlyName: NSString!
    
    public var avatarInfo: AvatarInfo!
}