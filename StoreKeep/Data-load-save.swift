//
//  DataModel.swift
//  ExampleApp
//
//  Created by shaik rehman on 7/11/23.
//

import Foundation
import SwiftUI

extension Data{
    private static func fileURL() throws -> URL {
            try FileManager.default.url(for: .documentDirectory,
                                        in: .userDomainMask,
                                        appropriateFor: nil,
                                        create: false)
            .appendingPathComponent("Store.data")
        }
    
    func loadData() async throws {
            let task = Task<[ServiceClass], Error> {
                let fileURL = try Self.fileURL()
                guard let data = try? SwiftUI.Data(contentsOf: fileURL) else {
                    return []
                }
                let allServices = try JSONDecoder().decode([ServiceClass].self, from: data)
                return allServices
            }
        
            Task {
                    // Perform your background task or asynchronous operation
                    let services = try await task.value
                    
                    // Update the value on the main thread
                    DispatchQueue.main.async {
                        self.data = services
                    }
                }
        }
    
    func save(services: [ServiceClass]) async throws {
            let task = Task {
                let data = try JSONEncoder().encode(services)
                let outfile = try Self.fileURL()
                try data.write(to: outfile)
            }
            _ = try await task.value
        }
}

extension ServiceClass{
    static let sampleData : [ServiceClass] =
        [
            ServiceClass(service: "t1", serviceSubList: [SubList(name: "t1", fields: [Pair(key: "t1", value: "t1")])])
        ]
}

extension SubList{
    static let sampleData : [SubList] =
        [
            SubList(name: "t1", fields: [Pair(key: "t1", value: "t1")])
        ]
}

extension Pair{
    static let sampleData : [Pair] =
        [
            Pair(key: "t1", value: "t1")
        ]
}
