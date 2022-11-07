//
//  Creature.swift
//  CatchEmAll
//
//  Created by Johnny Lion on 10/29/22.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id =  UUID().uuidString
    
    var name: String
    var url: String
    
    enum CodingKeys: CodingKey {
       
        case name, url
    }
}
