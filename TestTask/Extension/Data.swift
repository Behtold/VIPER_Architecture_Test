//
//  Data.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 27.06.2021.
//

import Foundation

extension Data {
    
    func decodeWithISO8601<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = //.iso8601
            .custom({ (decoder) -> Date in
                
                let formatter = DateFormatter()
                formatter.calendar = Calendar(identifier: .iso8601)
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.timeZone = TimeZone(secondsFromGMT: 0)

                let container = try decoder.singleValueContainer()
                let dateStr = try container.decode(String.self)

                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
                if let date = formatter.date(from: dateStr) {
                    return date
                }
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                if let date = formatter.date(from: dateStr) {
                    return date
                }
                throw RuntimeError("Invalid date")
            })
        return try decoder.decode(T.self, from: self)
    }
}
