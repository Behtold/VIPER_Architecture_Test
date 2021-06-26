//
//  StorageService.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 26.06.2021.
//

protocol StorageServiceProtocol {
    var launches: [Launch] {get}
    func filterLaunches(filter: String) -> [Launch]
    func saveLaunches(_ data: [Launch], completion: (() -> Void)?)
}

class StorageService: StorageServiceProtocol {
    
    var launches: [Launch] = []
    
    func filterLaunches(filter: String) -> [Launch] {
        return filter.isEmpty ? launches // Если пустой поиск - отдаем все,
            // иначе - фильтруем без учета регистра
            : launches.filter{ $0.name?.localizedCaseInsensitiveContains(filter) == true }
    }
    
    func saveLaunches(_ launches: [Launch], completion: (() -> Void)? = nil) {
        self.launches = launches
        if let completion = completion { completion() }
    }
    
    
    
}
