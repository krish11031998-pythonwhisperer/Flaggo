//
//  Flag.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import Foundation

public struct Country: Decodable {
    public let flags: Flag?
    public let flag: String?
    public let name: Name?
}

public struct Name: Decodable {
    public let official: String
    public let common: String
    public let nativeName: [String : Name]?
    
    enum CodingKeys: CodingKey {
        case official
        case common
        case nativeName
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.official = try container.decodeIfPresent(String.self, forKey: .official) ?? "No Official Name"
        self.common = try container.decodeIfPresent(String.self, forKey: .common) ?? "No Common Name"
        self.nativeName = try container.decodeIfPresent([String : Name].self, forKey: .nativeName)
    }
}

public struct Flag: Decodable {
    public let png: String
    public let svg: String
    public let description: String
    
    
    public enum CodingKeys: String, CodingKey {
        case png, svg, description = "alt"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.png = try container.decode(String.self, forKey: .png)
        self.svg = try container.decode(String.self, forKey: .svg)
        self.description = try container.decode(String.self, forKey: .description)
    }
    
    
}
