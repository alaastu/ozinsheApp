//
//  Screenshot.swift
//  ozinshe1
//
//  Created by Туйаара Алаас on 24.04.2023.
//


import Foundation
import SwiftyJSON

//    {
//        "id": 101,
//        "link": "http://api.ozinshe.com/core/public/V1/show/526",
//        "fileId": 526,
//        "movieId": 86
//    }

class Screenshot {
    public var id: Int = 0
    public var link: String = ""
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["link"].string {
            self.link = temp
        }
    }
}
