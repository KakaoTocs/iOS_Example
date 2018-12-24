//
//  Year.swift
//  TDD_Leap
//
//  Created by Jinu Kim on 20/12/2018.
//  Copyright © 2018 GAMZA. All rights reserved.
//

import Foundation

struct Year {
    let calendarYear: Int
    var isLeapYear: Bool {
        get {
            return calendarYear % 4 == 0 && (calendarYear % 100 != 0 || calendarYear % 400 == 0)
        }
    }
}
