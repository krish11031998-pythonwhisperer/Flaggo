//
//  Flag.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 23/07/2025.
//

import Foundation

public struct Flag: Decodable {
    public let png: String
    public let svg: String
    public let description: String?
    
    
    public enum CodingKeys: String, CodingKey {
        case png, svg, description = "alt"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.png = try container.decode(String.self, forKey: .png)
        self.svg = try container.decode(String.self, forKey: .svg)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
    }
}
