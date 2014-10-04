//
//  Group.swift
//  coffee
//
//  Created by achiel on 14-10-4.
//  Copyright (c) 2014年 1Clip. All rights reserved.
//

import Foundation

public class Group : IdObject {
    
    public var name: NSString!
    
    // This is only for internal usage
    internal var friends: Array<Friend>!
}

public class Friend : Character {
    
    public var groups: Array<Group>!
}