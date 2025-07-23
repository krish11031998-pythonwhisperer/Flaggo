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
    public let capital: [String]?
    public let region: String?
}
