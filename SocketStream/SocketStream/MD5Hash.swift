//
//  MD5Hash.swift
//  SocketStream
//
//  Created by DGSW_TEACHER on 2018. 5. 17..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import Foundation
//import CommonCrypto


//extension String {
//    func toMD5() -> String! {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        
//        CC_MD5(str!, strLen, result)
//        
//        let hash = NSMutableString()
//        for i in 0..<digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        
//        result.deinitialize()
//        
//        return String(format: hash as String)
//    }
//}
