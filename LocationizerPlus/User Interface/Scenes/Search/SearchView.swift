//
//  SearchView.swift
//  Locationizer
//
//  Created by Fineas Gavre on 16.09.2020.
//  Copyright © 2020 Fineas Gavre. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    // MARK: - Private Properties
    
    @EnvironmentObject private var locationService: LocationService
    
    @State private var latitude = ""
    @State private var longitude = ""
    @State private var location: Location?
    @State private var showErrorAlert = false
    
    // MARK: - View Body
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center, spacing: 5) {
                    TextField("Latitude", text: $latitude)
                        .background(Color(.systemGray6))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Longitude", text: $longitude)
                        .background(Color(.systemGray6))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    Button("Search") {
                        searchLocationFromCoordinates()
                    }.padding()
                    .alert(isPresented: $showErrorAlert) {
                        Alert(title: Text("Error"), message: Text("Coordinates need to be in Double format."), dismissButton: .default(Text("Close")))
                    }
                    
                    if let location = location {
                        SearchLocationView(location: location)
                    } else {
                        Text("No location found.")
                    }
                }.padding()
                Spacer()
            }.navigationBarTitle("Search")
        }
    }
    
    // MARK: - Private Methods

    private func searchLocationFromCoordinates() {
        // Using NumberFormatter because of the varying decimal symbol in locales
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        
        guard let latitude = formatter.number(from: latitude)?.doubleValue, let longitute = formatter.number(from: longitude)?.doubleValue else {
            showErrorAlert.toggle()
            return
        }
        
        location = locationService.getNearestLocationFrom(latitude: latitude, longitude: longitute)
        hideKeyboard()
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
