//
//  Review.swift
//  ChooseLife
//
//  Created by karlis.brahmanis on 13/08/2026.
//

import Foundation

struct Review: Identifiable, Codable {
    let id: UUID
    let author: String
    var rating: Int
    var title: String?
    var comment: String?
    var images: [String]?
}
