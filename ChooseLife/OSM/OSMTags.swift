//
//  OSMTags.swift
//  ChooseLife
//
//  Created by karlis.brahmanis on 13/08/2026.
//

import Foundation

enum OSMElementType: String, Codable {
    case node
    case way
    case relation
    
    var overpassPrefix: String {
        switch self {
        case .node:
            return "node"
        case .way:
            return "way"
        case .relation:
            return "relation"
        }
    }
}

struct OSMTag {
    let key: String
    let value: String
}

struct OSMQuery {
    let tags: [OSMTag]
    let elementTypes: [OSMElementType]
    
    func overpass(
        latitude: Double,
        longitude: Double,
        radius: Double
    ) -> String {
        
        var fullQuery = ""
        
        for tag in tags {
            let tagString = "[\"\(tag.key)\"=\"\(tag.value)\"]"
            
            let types = elementTypes.map {
                "\($0.overpassPrefix)\(tagString)"
            }
            
            fullQuery += types.map {
                "\($0)(around:\(Int(radius)),\(latitude),\(longitude));"
            }
            .joined(separator: "\n")
        }
        
        return fullQuery
    }
}

struct OSMQueryDefinition {
    let queries: [OSMQuery]
}

struct PlaceTypeOSMTags {
    
    static let all: [PlaceType: OSMQueryDefinition] = [
        
        // MARK: - Outdoor
        
        .hiking: OSMQueryDefinition(
            queries: [
                OSMQuery(
                    tags: [
                        OSMTag(key: "route", value: "hiking"),
                        OSMTag(key: "route", value: "foot")
                    ],
                    elementTypes: [
                        .relation
                    ]
                )
            ]
        ),
        
        .camping: OSMQueryDefinition(
            queries: [
                OSMQuery(
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
            ]
        ),
        
        .fishing: OSMQueryDefinition(
            queries: [
                OSMQuery(
                    tags: [
                        OSMTag(key: "leisure", value: "fishing"),
                        OSMTag(key: "fishing", value: "yes")
                    ],
                    elementTypes: [
                        .node,
                        .way
                    ]
                )
            ]
        ),
        
        .swimming: OSMQueryDefinition(
            queries: [
                OSMQuery(
                    tags: [
                        OSMTag(key: "leisure", value: "swimming_area"),
                        OSMTag(key: "natural", value: "beach")
                    ],
                    elementTypes: [
                        .node,
                        .way
                    ]
                )
            ]
        ),
        
        .cycling: OSMQueryDefinition(
            queries: [
                OSMQuery(
                    tags: [
                        OSMTag(key: "route", value: "bicycle"),
                        OSMTag(key: "route", value: "mtb")
                    ],
                    elementTypes: [
                        .relation
                    ]
                )
            ]
        ),
        
        .sightseeing: OSMQueryDefinition(
            queries: [
                OSMQuery(
                    tags: [
                        OSMTag(key: "tourism", value: "viewpoint"),
                        OSMTag(key: "tourism", value: "attraction"),
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
            ]
        ),
        
        
        // MARK: - Culture
        
        .culture: OSMQueryDefinition(
            queries: [
                OSMQuery(
                    tags: [
                        OSMTag(key: "tourism", value: "museum"),
                        OSMTag(key: "tourism", value: "gallery")
                    ],
                    elementTypes: [
                        .node,
                        .way,
                        .relation
                    ]
                )
            ]
        ),
        
        
        // MARK: - Entertainment
        
        .entertainment: OSMQueryDefinition(
            queries: [
                OSMQuery(
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
            ]
        ),
        
        
        // MARK: - Indoor Sports
        
        .indoorSports: OSMQueryDefinition(
            queries: [
                OSMQuery(
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
            ]
        ),
        
        
        // MARK: - Food
        
        .food: OSMQueryDefinition(
            queries: [
                OSMQuery(
                    tags: [
                        OSMTag(key: "amenity", value: "restaurant"),
                        OSMTag(key: "amenity", value: "fast_food")
                    ],
                    elementTypes: [
                        .node,
                        .way
                    ]
                )
            ]
        ),
        
        
        // MARK: - Cafes
        
        .cafe: OSMQueryDefinition(
            queries: [
                OSMQuery(
                    tags: [
                        OSMTag(key: "amenity", value: "cafe"),
                        OSMTag(key: "amenity", value: "ice_cream")
                    ],
                    elementTypes: [
                        .node,
                        .way
                    ]
                )
            ]
        ),
        
        
        // MARK: - Drinks / Nightlife
        
        .drink: OSMQueryDefinition(
            queries: [
                OSMQuery(
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
            ]
        )
    ]
}
