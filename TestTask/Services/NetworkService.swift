//
//  NetworkService.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getAllLauncher(completion: @escaping ([Launch]?, Error?) -> Void)
    static func decodeWithISO8601<T: Decodable>(_ data: Data?) throws -> T
}

class NetworkService: NetworkServiceProtocol {
    let baseURL: String
    
    init(_ baseURL: String = "https://api.spacexdata.com/v4") {
        self.baseURL = baseURL
    }
    
    func getAllLauncher(completion: @escaping ([Launch]?, Error?) -> Void) {
        request(path: "/launches") { data, error in
            if let data = data {
                do {
                    let launches: [Launch] = try NetworkService.decodeWithISO8601(data)
                    completion(launches, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
    }
    
    private func request(path: String, completion: @escaping (Data?, Error?) -> Void) {
        
        guard let encodeURL = (baseURL + path).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
              let url = URL(string: encodeURL) else {
            completion(nil, RuntimeError("Invalid url:\n\(baseURL + path)"))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }.resume()
    }
}

extension NetworkServiceProtocol {

    static func decodeWithISO8601<T: Decodable>(_ data: Data?) throws -> T {
        
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
        
        
        
        return try decoder.decode(T.self, from: data ?? Data())
    }
    
}
