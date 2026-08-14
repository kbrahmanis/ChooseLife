//
//  FormView.swift
//  ChooseLife
//
//  Created by karlis.brahmanis on 13/08/2026.
//

import SwiftUI
import MapKit

struct FormView: View {
    @State private var position: MapCameraPosition = .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                latitude: 56.8796,
                longitude: 24.6032
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 3.0,
                longitudeDelta: 7.0
            )
        )
    )
    
    @State private var startLocation: CLLocationCoordinate2D?
    @State private var locationIsLocked: Bool = false
    @State private var travelRadius: Double = 50
    @State private var startDate: Date = Date.now
    @State private var endDate: Date = Date.now.addingTimeInterval(3600) // Default to 1 hour later
    let transportationModes = ["On Foot", "Bycicle", "Car"] // Add public transport later
    @State private var selectedTransportMode: String = "Car"
    @State private var tagsToSearch: Set<PlaceType> = []
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Select your start location:") {
                    MapReader { proxy in
                        Map(position: $position) {
                            
                            // Show marker only when a location has been selected
                            if let coordinate = startLocation {
                                Marker(
                                    "Selected start location",
                                    coordinate: coordinate
                                )
                            }
                            
                            if locationIsLocked {
                                MapCircle(
                                    center: startLocation!,
                                    radius: travelRadius
                                )
                                .foregroundStyle(.blue.opacity(0.5))
                                
                            }
                            
                        }
                        .frame(height: 200)
                        .onTapGesture { screenLocation in
                            
                            // Convert the screen tap into a geographic coordinate
                            if let coordinate = proxy.convert(
                                screenLocation,
                                from: .local
                            ){
                                if !locationIsLocked {
                                    startLocation = coordinate
                                }
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Select your travel distance radius: \(Int(travelRadius)) km")
                            Slider(value: $travelRadius, in: 0...300000)// Distance to travel
                                .disabled(!locationIsLocked)
                        }
                    }
                }
                
                Section("Select your travel dates:") {
                    DatePicker("Trip Start:", selection: $startDate, displayedComponents: [.date, .hourAndMinute]) // Date to travel
                    
                    DatePicker("Trip End:", selection: $endDate, displayedComponents: [.date, .hourAndMinute]) // Date to travel
                }
                
                Section("Select your mode of transportation:") {
                    Picker("Transportation Mode", selection: $selectedTransportMode) {
                        ForEach(transportationModes, id: \.self) { mode in
                            Text(mode)
                        }
                    }
                }
                
                Section("Place types to search for:") {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(PlaceType.allCases, id: \.self) { type in
                            Button {
                                if tagsToSearch.contains(type) {
                                    tagsToSearch.remove(type)
                                } else {
                                    tagsToSearch.insert(type)
                                    print("Selected tags: \(tagsToSearch)")
                                }
                            } label: {
                                Text(type.rawValue.capitalized)
                                    .frame(maxWidth: .infinity)
                                    .padding(8)
                                    .foregroundStyle(.white)
                                    .background(
                                        tagsToSearch.contains(type)
                                        ? Color.blue
                                        : Color.gray
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    Button {
                        if tagsToSearch.count == PlaceType.allCases.count {
                            tagsToSearch.removeAll()
                        } else {
                            tagsToSearch = Set(PlaceType.allCases)
                        }
                    } label: {
                        Text("Select All")
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .foregroundStyle(.white)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .buttonStyle(.plain)
                }
            }
            .toolbar {
                ToolbarItem {
                    if startLocation != nil {
                        Button {
                            locationIsLocked.toggle()
                        } label: {
                            Image(systemName: locationIsLocked ? "lock.fill" : "lock.open")
                                .padding(10)
                                .background(Color.white.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .padding(5)
                    }
                }
            }
            
            Button {
                
            } label: {
                Text("Submit")
            }
        }
    }
}

#Preview {
    FormView()
}
