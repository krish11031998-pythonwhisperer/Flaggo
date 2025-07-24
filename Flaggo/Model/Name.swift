//
//  Name.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 23/07/2025.
//

import Foundation

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
