//
//  Name.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 23/07/2025.
//

import Foundation

 struct Name: Decodable {
     let official: String
     let common: String
     let nativeName: [String : Name]?
    
    enum CodingKeys: CodingKey {
        case official
        case common
        case nativeName
    }
    
     init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.official = try container.decodeIfPresent(String.self, forKey: .official) ?? "No Official Name"
        self.common = try container.decodeIfPresent(String.self, forKey: .common) ?? "No Common Name"
        self.nativeName = try container.decodeIfPresent([String : Name].self, forKey: .nativeName)
    }
}
