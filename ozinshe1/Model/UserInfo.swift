//
//  UserInfo.swift
//  ozinshe1
//
//  Created by Туйаара Алаас on 14.08.2023.
//

import Foundation
import SwiftyJSON

struct User {
    var email = ""
    
    init() {
        
    }
    
    init(json: JSON) {
        if let temp = json["email"].string {
            self.email = temp
        }
    }
}

struct UserInfo {
    var name = ""
    var user: User = User()
    var phoneNumber = ""
    var birthday = ""
    
    init() {
        
    }
    
    init(json: JSON) {
        if let temp = json["name"].string {
            self.name = temp
        }
        if let temp = json["phoneNumber"].string {
            self.phoneNumber = temp
        }
        if let temp = json["birthDate"].string {
            self.birthday = temp
        }
        if json["user"].exists() {
            self.user = User(json: json["user"])
        }
    }
}
