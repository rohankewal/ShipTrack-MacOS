//
//  ContentView.swift
//  ShipTrack-MacOS
//
//  Created by Rohan Kewalramani on 11/8/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack {
            // Top Map Card
            MapView()
                .frame(maxHeight: .infinity) // Adjust height as needed
            
            // Middle Cards: Table and Graph
            HStack(spacing: 20) {
                TableView()
                    .frame(maxWidth: .infinity)
                
                GraphView()
                    .frame(maxWidth: .infinity)
            }
            
            // Bottom Table Card
            TableView()
                .frame(maxHeight: .infinity) // Adjust height as needed
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Text("ShipTrack Dashboard")
                    .font(.headline)
            }
            ToolbarItem(placement: .automatic) {
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                }
                .onChange(of: isDarkMode) { _ in
                    updateAppearance()
                }
            }
        }
        .onAppear {
            updateAppearance()
        }
    }
    
    private func updateAppearance() {
        NSApp.appearance = isDarkMode ? NSAppearance(named: .darkAqua) : NSAppearance(named: .aqua)
    }
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011286, longitude: -116.166868), // Example coordinates
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )

    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct Shipment {
    var id: Int
    var description: String
    var status: String
    var estimatedDelivery: String
}

struct TableView: View {
    // Example data array for Shipments
    let shipments: [Shipment] = [
        Shipment(id: 1, description: "Electronics", status: "In Transit", estimatedDelivery: "2023-12-10"),
        Shipment(id: 2, description: "Books", status: "Delivered", estimatedDelivery: "2023-11-05"),
        Shipment(id: 3, description: "Steel", status: "Delayed", estimatedDelivery: "2023-11-04"),
        // Add more data as needed
    ]

    var body: some View {
        List(shipments, id: \.id) { shipment in
            HStack {
                VStack(alignment: .leading) {
                    Text(shipment.description)
                        .font(.headline)
                    Text("Estimated Delivery: \(shipment.estimatedDelivery)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()

                Text(shipment.status)
                    .fontWeight(.bold)
                    .padding(8)
                    .background(
                        shipment.status == "In Transit" ? Color.blue :
                        shipment.status == "Delayed" ? Color.red : Color.green
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct GraphView: View {
    var body: some View {
        // Implement your Graph here
        Text("Graph Placeholder")
    }
}

#Preview {
    ContentView()
}
