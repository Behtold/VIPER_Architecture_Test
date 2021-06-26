//
//  NetworkService.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 24.06.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getAllLauncher(completion: @escaping ([Launch]?, String?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    let baseURL: String
    
    init(_ baseURL: String = "https://api.spacexdata.com/v4") {
        self.baseURL = baseURL
    }
    
    func getAllLauncher(completion: @escaping ([Launch]?, String?) -> Void) {
        request(path: "/launches") { data, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let launches = try decoder.decode([Launch].self, from: data)
                    completion(launches, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }
    
    private func request(path: String, completion: @escaping (Data?, String?) -> Void) {
        
        guard let encodeURL = (baseURL + path).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
              let url = URL(string: encodeURL) else {
            completion(nil, "Некорректный запрос:\n\(baseURL + path)")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            completion(data, nil)
        }.resume()
    }
    
}
