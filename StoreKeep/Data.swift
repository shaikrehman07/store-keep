//
//  Data.swift
//  ExampleApp
//
//  Created by shaik rehman on 7/10/23.
//

import Foundation

class Data: ObservableObject, Codable {
    @Published var data = [ServiceClass]()

    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(){}

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([ServiceClass].self, forKey: .data)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
    }
}

class ServiceClass: ObservableObject, Codable {
    @Published var service: String
    @Published var serviceSubList: [SubList]
    
    enum CodingKeys: String, CodingKey {
        case service
        case serviceSubList
    }
    
    init(service: String, serviceSubList: [SubList]) {
        self.service = service
        self.serviceSubList = serviceSubList
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        service = try container.decode(String.self, forKey: .service)
        serviceSubList = try container.decode([SubList].self, forKey: .serviceSubList)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(service, forKey: .service)
        try container.encode(serviceSubList, forKey: .serviceSubList)
    }
}

class SubList: ObservableObject, Codable {
    @Published var name: String
    @Published var fields: [Pair]
    
    enum CodingKeys: String, CodingKey {
        case name
        case fields
    }
    
    init(name: String, fields: [Pair]) {
        self.name = name
        self.fields = fields
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        fields = try container.decode([Pair].self, forKey: .fields)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(fields, forKey: .fields)
    }
}

class Pair: Codable {
    var key: String
    var value: Any
    
    enum CodingKeys: CodingKey {
        case key
        case value
    }
    
    init(key: String, value: Any) {
        self.key = key
        self.value = value
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        key = try container.decode(String.self, forKey: .key)
        if let stringValue = try? container.decode(String.self, forKey: .value) {
            value = stringValue
        } else {
            value = try container.decode(Int.self, forKey: .value) // Update with the appropriate type
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(key, forKey: .key)
        try container.encode(String(describing: value), forKey: .value)
    }
}

