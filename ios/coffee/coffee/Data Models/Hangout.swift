//
//  Hangout.swift
//  coffee
//
//  Created by achiel on 14-10-4.
//  Copyright (c) 2014年 1Clip. All rights reserved.
//

public class Hangout : IdObject {
    
    public var activity: NSString!
    
    public var subject: NSString!
    
    public var location: NSString!
    
    public var startTime: NSDate!
    
    public var endTime: NSDate!
    
    // This might be changed since JSONModel does not support serialization for Array
    public var participators: Array<Participator>!
}

public class HangoutSummary : IdObject {

    public var activity: NSString!
    
    public var subject: NSString!
    
    public var state: NSString!
    
    public var organizer: Participator!
    
    public var numAccepted: Int!
    
    public var numDeclined: Int!
    
    public var numPending: Int!
}

public class Participator : Character {

    public var role: NSString!
    
    public var state: NSString!
    
    public var errorCode: Int!
}
