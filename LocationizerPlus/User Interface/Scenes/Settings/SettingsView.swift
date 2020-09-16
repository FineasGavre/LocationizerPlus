//
//  SettingsView.swift
//  LocationizerPlus
//
//  Created by Fineas Gavre on 16.09.2020.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var locationServices: LocationService
    @EnvironmentObject private var locationDataObservable: DataObservable<Location>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Content")) {
                        Text("There are \(locationServices.locations.items.count) locations loaded.")
                        Button("Load locations from server") {
                            locationServices.fetchRemoteLocationsAndSaveIntoRealm()
                        }.foregroundColor(.blue)
                        Button("Remove all stored locations") {
                            locationServices.removeAllLocationsFromRealm()
                        }.foregroundColor(.red)
                    }
                }.listStyle(PlainListStyle())
            }.navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
