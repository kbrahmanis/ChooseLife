//
//  Trip.swift
//  ChooseLife
//
//  Created by karlis.brahmanis on 13/08/2026.
//

import Foundation

struct Trip: Identifiable, Codable {
    var id: UUID
    var firstPlace: Place
    var stopoverPlaces: [Place]?
    var lastPlace: Place
    var tripStart: Date
    var tripDuration: Double
    var tripReview: Review?
}
