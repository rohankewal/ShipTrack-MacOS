//
//  ContentView.swift
//  ShipTrack-MacOS
//
//  Created by Rohan Kewalramani on 11/8/23.
//

import SwiftUI
import MapKit
import Charts

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack {
            Text("Map")
                .font(.title)
                .fontWeight(.bold)
            // Top Map Card
            MapView()
                .frame(maxHeight: .infinity) // Adjust height as needed
            
            // Middle Cards: Table and Graph
            HStack(spacing: 20) {
                ShipmentsTableView()
                    .frame(maxWidth: .infinity)
                
                GraphView()
                    .frame(maxWidth: .infinity)
            }
            
            // Bottom Table Card
            AccountingTableView()
                .frame(maxHeight: .infinity) // Adjust height as needed
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Text("ShipTrack Dashboard")
                    .font(.headline)
            }

            ToolbarItemGroup(placement: .automatic) {
                Button(action: {
                    // Action to add a shipment
                    
                }) {
                    Label("Add Shipment", systemImage: "plus")
                }

                Button(action: {
                    // Action to export data
                }) {
                    Label("Export", systemImage: "square.and.arrow.up")
                }

                Button(action: {
                    // Action to import data
                }) {
                    Label("Import", systemImage: "square.and.arrow.down")
                }

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
    var method: String
    var status: String
    var estimatedDelivery: String
}

struct ShipmentsTableView: View {
    // Example data array for Shipments
    let shipments: [Shipment] = [
        Shipment(id: 1, description: "Electronics", method: "air", status: "In Transit", estimatedDelivery: "2023-12-10"),
        Shipment(id: 2, description: "Books", method: "ship", status: "Delivered", estimatedDelivery: "2023-11-05"),
        Shipment(id: 3, description: "Steel", method: "rail", status: "Delayed", estimatedDelivery: "2023-11-04"),
        // Add more data as needed
    ]
    
    var body: some View {
        List(shipments, id: \.id) { shipment in
            HStack {
                VStack(alignment: .leading) {
                    Text(shipment.description)
                        .font(.largeTitle)
                    Text("Estimated Delivery: \(shipment.estimatedDelivery)")
                        .font(.title)
                        // .foregroundColor(.gray)
                    Text("Delivery Method: \(shipment.method)")
                        .font(.title)
                        // .foregroundColor(.gray)
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


// todo: create a different table for accounts for the bottom table
struct ShipmentAccounting {
    var id: Int
    var cost: Double
    var revenue: Double
    var profit: Double {
        revenue - cost
    }
}

struct AccountingTableView: View {
    // Example data array for Shipment Accounting
    let accountingData: [ShipmentAccounting] = [
        ShipmentAccounting(id: 1, cost: 1200.00, revenue: 1500.00),
        ShipmentAccounting(id: 2, cost: 800.00, revenue: 950.00),
        // Add more data as needed
    ]

    var body: some View {
        List(accountingData, id: \.id) { data in
            HStack {
                Text("ID: \(data.id)")
                    .frame(width: 50, alignment: .leading)

                Spacer()

                VStack(alignment: .trailing) {
                    Text("Cost: $\(data.cost, specifier: "%.2f")")
                    Text("Revenue: $\(data.revenue, specifier: "%.2f")")
                    Text("Profit: $\(data.profit, specifier: "%.2f")")
                        .foregroundColor(data.profit >= 0 ? .green : .red)
                }
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
