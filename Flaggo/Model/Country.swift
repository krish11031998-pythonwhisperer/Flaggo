//
//  Flag.swift
//  Flaggo
//
//  Created by Krishna Venkatramani on 22/07/2025.
//

import Foundation

 struct Country: Decodable {
     let flags: Flag?
     let flag: String?
     let name: Name?
     let capital: [String]?
     let region: String?
     let subregion: String?
     let coatOfArms: Flag?
     let languages: [String:String]?
     let currencies: [String:Currency]?
     let demonyms: [String: Demonym]?
     let area: Double?
     let population: Int?
}
