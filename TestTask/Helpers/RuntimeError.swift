//
//  RuntimeError.swift
//  TestTask
//
//  Created by Andrey Bekhtold on 27.06.2021.
//

struct RuntimeError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
