//
//  UserInformation.swift
//  SignUp
//
//  Created by DGSW_TEACHER on 2018. 4. 12..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import Foundation
import UIKit

class UserInformation {
    static let shared: UserInformation = UserInformation()
    
    var id: String?
    var pw: String?
    var pwCheck: String?
    var introduce: String?
    var profileImage: UIImage?
    var phoneNumber: String?
    var birthday: String?
    
    var userDetailInfo: Dictionary<String, Any>? {
        get {
            if let intro = self.introduce,
                let profile = self.profileImage,
                let phone = self.phoneNumber,
                let birth = self.birthday {
                return ["intro": intro, "profile": profile, "phone": phone, "birth": birth]
            } else {
                return nil
            }
        }
    }
    
    static func save(user: UserInformation) -> Void {
        let defaults = UserDefaults.standard
        
        var ids: Array<String> = defaults.object(forKey: "ids") as! Array<String>
        var pws: Array<String> = defaults.object(forKey: "pws") as! Array<String>
        
        if let userID = user.id,
            let userPW = user.pw,
            let userInfo = user.userDetailInfo {
            
            ids.append(userID)
            pws.append(userPW)
            
            defaults.set(ids, forKey: "ids")
            defaults.set(pws, forKey: "pws")
            defaults.set(userInfo, forKey: userID)
        }
        
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
