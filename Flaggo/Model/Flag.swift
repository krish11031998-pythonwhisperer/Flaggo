//
//  Flag.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 23/07/2025.
//

import Foundation

 struct Flag: Decodable {
     let png: String
     let svg: String?
     let description: String?
    
    
     enum CodingKeys: String, CodingKey {
        case png, svg, description = "alt"
    }
    
     init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.png = try container.decodeIfPresent(String.self, forKey: .png) ?? ""
        self.svg = try container.decodeIfPresent(String.self, forKey: .svg) ?? nil
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? nil
    }
}
