//
//  Place.swift
//  ChooseLife
//
//  Created by karlis.brahmanis on 04/08/2026.
//

import Foundation

struct Place: Identifiable, Codable {
    var id: UUID
    var osmId: Int
    var name: String
    var description: String
    var images: [String]?
    var type: PlaceType
    var estimatedPrice: PlacePrice
    var website: String?
    var latitude: Double
    var longitude: Double
    var address: String?
    var reviews: [Review]?
}

enum PlacePrice: Codable {
    case free, cheap, moderate, expensive
}
