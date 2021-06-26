//
//  Launch.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

// Источник данных https://api.spacexdata.com/v4/launches
// https://github.com/r-spacex/SpaceX-API/tree/master/docs/v4

import Foundation

class Launch: Decodable {
    
    var id: Int
    var name: String?
    var date: Date?
    var details: String?
    var success: Bool?
    
    enum CodingKeys: String, CodingKey {
        // Для теста решил не заморачиваться с оригинальным id, номер запуска, по идее, тоже уникален
        case id = "flight_number"
        case name
        // Дата в формате UTC (кончается на 0Z) не декодируется дефолтным декодером .iso8601
        // без дополнительных опций, поэтому взял со сдвигом по часовому поясу
        case date = "date_local"
        case details
        case success
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        date = try container.decodeIfPresent(Date.self, forKey: .date)
        details = try container.decodeIfPresent(String.self, forKey: .details)
        success = try container.decodeIfPresent(Bool.self, forKey: .success)
    }
}
