//
//  OSMElement.swift
//  ChooseLife
//
//  Created by karlis.brahmanis on 14/08/2026.
//

import Foundation

/* struct OSMElement
    
 This structure represents the OSM response
 
*/

struct OSMElement: Codable {
    let type: OSMElementType
    let id: Int
    
    // for nodes
    let lat: Double?
    let lon: Double?
    
    // for ways/relations when using "out center"
    let center: OSMCenter?
    
    let tags: [String: String]?
}

struct OSMCenter: Codable {
    let lat: Double
    let lon: Double
}
