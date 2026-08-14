//
//  OverpassService.swift
//  ChooseLife
//
//  Created by karlis.brahmanis on 14/08/2026.
//

import Foundation
import _LocationEssentials

struct OverpassResponse: Codable {
    var elements: [OSMElement]
}

enum OverpassError: Error {
    case invalidResponse
    case httpError(Int, String?)
}

final class OverpassService {
    
    private let overpassURL = URL(string: "https://overpass-api.de/api/interpreter")!
    
    // MARK: - Full OSM item fetching function that handles retries and errors
    
    func fetch(
        definitions: [OSMQueryDefinition],
        coordinate: CLLocationCoordinate2D,
        radius: CLLocationDistance
    ) async throws -> [OSMElement]{
        
        let query = buildQuery(
            definitions: definitions,
            coordinate: coordinate,
            radius: radius
        )
        
        var lastError: Error?
        
        for attempt in 1...3 {
            do {
                return try await preformRequest(query: query)
            } catch {
                lastError = error
                
                print("Attempt \(attempt) failed with error: \(error)")
                
                if attempt < 3 {
                    try await Task.sleep(
                        for: .seconds(Double(attempt))
                    )
                }
            }
        }
        
        throw lastError!
    }
    
    // MARK: - Function that builds the Overpass query string based on the provided definitions, coordinates, and radius
    
    func buildQuery(
        definitions: [OSMQueryDefinition],
        coordinate: CLLocationCoordinate2D,
        radius: CLLocationDistance
    ) -> String {
        
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        let queries = definitions
            .flatMap(\.queries)
            .map {
                $0.overpass(
                    latitude: latitude,
                    longitude: longitude,
                    radius: radius
                )
            }
            .joined(separator: "\n")
        
        return """
        [out:json][timeout:60];
        
        (
        \(queries)
        );
        
        out center;
        """
    }
    
    // MARK: - Function that handles creating the actual request and decoding the response
    
    func preformRequest(query: String) async throws -> [OSMElement] {
        var request = URLRequest(url: overpassURL)
        request.httpMethod = "POST"
        request.setValue(
            "application/x-www-form-urlencoded",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.httpBody = "data=\(query)".data(using: .utf8)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw OverpassError.invalidResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            let message = String(data: data, encoding: .utf8)

            throw OverpassError.httpError(
                httpResponse.statusCode,
                message
            )
        }
        
        let decoded =
            try JSONDecoder().decode(
                OverpassResponse.self,
                from: data
            )
        
        return decoded.elements
    }
}
