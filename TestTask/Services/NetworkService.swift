//
//  NetworkService.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getAllLauncher(completion: @escaping ([Launch]?, Error?) -> Void)
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
                    let launches: [Launch] = try data.decodeWithISO8601()
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
