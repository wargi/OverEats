//
//  UserManager.swift
//  OverEats
//
//  Created by SolChan Ahn on 2018. 4. 21..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

struct UserManager {
    private init() {}
    
    static var setUser: UserData? {
        get { return nil }
        set {
            _token = newValue?.token
            email = newValue?.user.email
            firstName = newValue?.user.firstName
            lastName = newValue?.user.lastName
            phoneNumber = newValue?.user.phoneNumber
            imgProfile = newValue?.user.imgProfile
        }
    }
    
    private static var _token: String?
    
    static var token: String? {
        get { return _token == nil ? nil : "token \(_token!)" }
        set { _token = newValue }
    }
    
    static var email: String? // 이메일
    static var firstName: String? // 이름
    static var lastName: String? // 성
    static var phoneNumber: String? // 폰 번호
    static var imgProfile: String? // 이미지 URL
    
    static var name: String?
    static var formattedAddress: String?
}
