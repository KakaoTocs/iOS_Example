//
//  UserInformation.swift
//  SignUp
//
//  Created by DGSW_TEACHER on 2018. 4. 12..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import Foundation

class UserInformation {
    static let shared: UserInformation = UserInformation()
    
    var id: String!
    var pw: String!
    var pwCheck: String!
    
    var userDetailInfo: Dictionary<String, String> = [String: String]()
    
    static func save(user: UserInformation) -> Void {
        let defaults = UserDefaults.standard
        
        var ids: Array<String> = defaults.object(forKey: "ids") as! Array<String>
        var pws: Array<String> = defaults.object(forKey: "pws") as! Array<String>
        
        ids.append(user.id)
        pws.append(user.pw)
        
        defaults.set(ids, forKey: "ids")
        defaults.set(pws, forKey: "pws")
        defaults.set(user.userDetailInfo, forKey: user.id)
    }
    
    static func check(id: String, pw: String) -> Bool {
        let defaults = UserDefaults.standard
        
        let ids: Array<String> = defaults.object(forKey: "ids") as! Array<String>
        let pws: Array<String> = defaults.object(forKey: "pws") as! Array<String>
        
        if ids.contains(id), pws.contains(pw) {
            return true
        }
        else {
            return false
        }
    }
}
