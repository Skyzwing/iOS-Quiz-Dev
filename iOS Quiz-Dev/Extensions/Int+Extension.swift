//
//  Int+Extension.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 22/10/23.
//

import Foundation

extension Int {
    func integerFormattedString() -> String {
        if self >= 100000 {
            let thousands = self / 1000
            return "\(thousands)k"
        } else {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: self)) ?? ""
        }
    }
}
