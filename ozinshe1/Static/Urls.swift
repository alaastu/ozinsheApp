//
//  Urls.swift
//  ozinshe1
//
//  Created by Туйаара Алаас on 21.04.2023.
//

import Foundation

class Urls {
    static let BASE_URL = "http://api.ozinshe.com/core/V1/"
    
    static let SIGN_IN_URL = "http://api.ozinshe.com/auth/V1/signin"
    static let FAVORITE_URL = BASE_URL + "favorite/"
    static let PROFILE_URL = BASE_URL + "user/profile"
    static let CATEGORIES_URL =  BASE_URL + "categories"
    static let MOVIES_BY_CATEGORY_URL = BASE_URL + "movies/page"
    static let CHANGE_PASSWORD = BASE_URL + "user/profile/changePassword"
    static let SEARCH_MOVIES_URL = BASE_URL + "movies/serials"
}
