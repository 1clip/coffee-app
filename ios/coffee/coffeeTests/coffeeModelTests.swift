//
//  coffeeTests.swift
//  coffeeTests
//
//  Created by achiel on 14-9-29.
//  Copyright (c) 2014年 1Clip. All rights reserved.
//

import UIKit
import XCTest
import coffee

class coffeeModelTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserModel() {
        var user = User()
        
        user.id = "3293082493"
        user.loginName = "tom_slick"
        user.friendlyName = "fiendlyName"
        user.locale = "US"
        user.gender = "male"
        user.birth = "1980-01-01"
        user.cellPhone = "+1 (415) 123-456"

        user.avatarInfo = AvatarInfo()
        user.avatarInfo.id = "my_avatart"
        user.avatarInfo.token = "token"
        
        var error: JSONModelError? = nil
        var userFromJson = User(string: user.toJSONString(), error: &error)
      
        XCTAssertEqual(userFromJson.cellPhone, user.cellPhone, "Pass")
    }
    
    func testHangoutModel() {
        var hangout = Hangout()
        
        hangout.activity = "Dinner"
        hangout.participators = Array<Participator>()
        
        var participator = Participator();
        participator.id = "1234123"
        participator.role = ParticipatorRole.Organizer.toRaw()
        hangout.participators.append(participator)
        
        //NSLog(hangout.toJSONString())
    }
}
