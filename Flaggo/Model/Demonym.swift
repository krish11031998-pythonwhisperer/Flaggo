//
//  Demonym.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 24/07/2025.
//

import Foundation

public struct Demonym: Decodable {
    public let female: String
    public let male: String
    
    enum CodingKeys: String, CodingKey {
        case female = "f"
        case male = "m"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.female = try container.decodeIfPresent(String.self, forKey: .female) ?? "No Demonym for female"
        self.male = try container.decodeIfPresent(String.self, forKey: .male) ?? "No Demonym for male"
    }
}
