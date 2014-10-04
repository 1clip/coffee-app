//
//  Enums.swift
//  coffee
//
//  Created by achiel on 14-10-4.
//  Copyright (c) 2014年 1Clip. All rights reserved.
//

// CAUSION: JSONModel does not support enum currently.
//          Use string for enum property in various classes.

// User enumerations
public enum GENDER : String {
    case Male = "male"
    case Female = "female"
}

// Hangout enumerations
public enum HangoutState : String {
    case Active = "active"
    case Overdue = "overdue"
}

public enum ParticipatorRole : String {
    case Organizer = "organizer"
    case Invitee = "invitee"
}

public enum ParticipatorState : String {
    case Pending = "pending"
    case Accept = "accept"
    case Reject = "reject"
}



