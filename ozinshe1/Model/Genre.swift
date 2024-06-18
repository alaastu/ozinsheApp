//
//  Genre.swift
//  ozinshe1
//
//  Created by Туйаара Алаас on 24.04.2023.
//

import Foundation
import SwiftyJSON

//   {
//       "id": 4,
//       "name": "Ойын-сауық",
//       "fileId": 360,
//       "link": "http://api.ozinshe.com/core/public/V1/show/360",
//       "movieCount": null
//    }

class Genre {
    public var id: Int = 0
    public var name: String = ""
    public var link: String = ""
    
    init(json: JSON) {
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["name"].string {
            self.name = temp
        }
        if let temp = json["link"].string {
            self.link = temp
        }
    }
}
