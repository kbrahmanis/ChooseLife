//
//  OSMTags.swift
//  ChooseLife
//
//  Created by karlis.brahmanis on 13/08/2026.
//

import Foundation

enum OSMElementType {
    case node
    case way
    case relation
}

struct OSMTag {
    let key: String
    let value: String
}

struct OSMQuery {
    let placeType: PlaceType
    let tags: [OSMTag]
    let elementTypes: [OSMElementType]
}

struct PlaceTypeOSMTags {
    
    // MARK: - Outdoor
    
    static let hiking = OSMQuery(
        placeType: .hiking,
        tags: [
            OSMTag(key: "route", value: "hiking"),
            OSMTag(key: "route", value: "foot")
        ],
        elementTypes: [
            .relation
        ]
    )
    
    static let camping = OSMQuery(
        placeType: .camping,
        tags: [
            OSMTag(key: "tourism", value: "camp_site"),
            OSMTag(key: "tourism", value: "picnic_site")
        ],
        elementTypes: [
            .node,
            .way,
            .relation
        ]
    )
    
    static let fishing = OSMQuery(
        placeType: .fishing,
        tags: [
            OSMTag(key: "leisure", value: "fishing"),
            OSMTag(key: "fishing", value: "yes")
        ],
        elementTypes: [
            .node,
            .way
        ]
    )
    
    static let swimming = OSMQuery(
        placeType: .swimming,
        tags: [
            OSMTag(key: "leisure", value: "swimming_area"),
            OSMTag(key: "natural", value: "beach")
        ],
        elementTypes: [
            .node,
            .way
        ]
    )
    
    static let cycling = OSMQuery(
        placeType: .cycling,
        tags: [
            OSMTag(key: "route", value: "bicycle"),
            OSMTag(key: "route", value: "mtb")
        ],
        elementTypes: [
            .relation
        ]
    )
    
    static let sightseeing = OSMQuery(
        placeType: .sightseeing,
        tags: [
            OSMTag(key: "tourism", value: "viewpoint"),
            OSMTag(key: "tourism", value: "attraction")
        ],
        elementTypes: [
            .node,
            .way,
            .relation
        ]
    )
    
    
    // MARK: - Culture
    
    static let culture = OSMQuery(
        placeType: .culture,
        tags: [
            OSMTag(key: "tourism", value: "museum"),
            OSMTag(key: "tourism", value: "gallery"),
            OSMTag(key: "historic", value: "castle"),
            OSMTag(key: "historic", value: "fort"),
            OSMTag(key: "historic", value: "ruins"),
            OSMTag(key: "historic", value: "monument"),
            OSMTag(key: "historic", value: "memorial"),
            OSMTag(key: "historic", value: "archaeological_site")
        ],
        elementTypes: [
            .node,
            .way,
            .relation
        ]
    )
    
    
    // MARK: - Entertainment
    
    static let entertainment = OSMQuery(
        placeType: .entertainment,
        tags: [
            OSMTag(key: "amenity", value: "cinema"),
            OSMTag(key: "amenity", value: "theatre"),
            OSMTag(key: "leisure", value: "bowling_alley"),
            OSMTag(key: "leisure", value: "escape_game"),
            OSMTag(key: "tourism", value: "zoo"),
            OSMTag(key: "tourism", value: "aquarium")
        ],
        elementTypes: [
            .node,
            .way,
            .relation
        ]
    )
    
    
    // MARK: - Indoor Sports
    
    static let indoorSports = OSMQuery(
        placeType: .indoorSports,
        tags: [
            OSMTag(key: "leisure", value: "fitness_centre"),
            OSMTag(key: "leisure", value: "sports_centre"),
            OSMTag(key: "leisure", value: "ice_rink"),
            OSMTag(key: "sport", value: "climbing"),
            OSMTag(key: "sport", value: "swimming"),
            OSMTag(key: "sport", value: "tennis"),
            OSMTag(key: "sport", value: "basketball"),
            OSMTag(key: "sport", value: "table_tennis"),
            OSMTag(key: "sport", value: "10pin")
        ],
        elementTypes: [
            .node,
            .way
        ]
    )
    
    
    // MARK: - Food
    
    static let food = OSMQuery(
        placeType: .food,
        tags: [
            OSMTag(key: "amenity", value: "restaurant"),
            OSMTag(key: "amenity", value: "fast_food")
        ],
        elementTypes: [
            .node,
            .way
        ]
    )
    
    
    // MARK: - Cafes
    
    static let cafe = OSMQuery(
        placeType: .cafe,
        tags: [
            OSMTag(key: "amenity", value: "cafe"),
            OSMTag(key: "amenity", value: "ice_cream")
        ],
        elementTypes: [
            .node,
            .way
        ]
    )
    
    
    // MARK: - Drinks / Nightlife
    
    static let drink = OSMQuery(
        placeType: .drink,
        tags: [
            OSMTag(key: "amenity", value: "bar"),
            OSMTag(key: "amenity", value: "pub"),
            OSMTag(key: "amenity", value: "nightclub"),
            OSMTag(key: "craft", value: "brewery"),
            OSMTag(key: "craft", value: "winery")
        ],
        elementTypes: [
            .node,
            .way
        ]
    )
}
