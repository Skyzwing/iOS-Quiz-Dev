//
//  String.swift
//  iOS Quiz-Dev
//
//  Created by Surachet Yaitammasan on 22/10/23.
//

import Foundation

extension String {
    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ") -> String? {
        let isoDateFormatter = ISO8601DateFormatter()
                isoDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                
                if let date = isoDateFormatter.date(from: self) {
                    let outputDateFormatter = DateFormatter()
                    outputDateFormatter.locale = Locale(identifier: "th_TH")
                    outputDateFormatter.dateFormat = "dd MMM yyyy / HH:mm"
                    outputDateFormatter.timeZone = TimeZone(identifier: "Asia/Bangkok")
                    return "อัปเดตล่าสุด \(outputDateFormatter.string(from: date)) น."
                }
                
                return nil

    }
}
