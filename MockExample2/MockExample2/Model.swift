//
//  Model.swift
//  MockExample2
//
//  Created by Jinu Kim on 21/12/2018.
//  Copyright © 2018 GAMZA. All rights reserved.
//

import Foundation

enum RamenSoup {
    case shio
    case shoyu
    case miso
    case tonkotsu
}

protocol CookProtocol {
    func cookRamen(bowls: Int, soup: RamenSoup, extras: [String]) -> Void
}

struct Waiter {
    let cook: CookProtocol
    
    func order() {
        cook.cookRamen(bowls: 2, soup: .miso, extras: ["wakame", "tamago"])
    }
}

class MockCook: CookProtocol {
    func cookRamen(bowls: Int, soup: RamenSoup, extras: [String]) {
        
    }
}
