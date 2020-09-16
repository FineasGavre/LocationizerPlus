//
//  LocationListView.swift
//  Location
//
//  Created by Fineas Gavre on 15.09.2020.
//  Copyright © 2020 Fineas Gavre. All rights reserved.
//

import SwiftUI

struct LocationListView: View {
    
    // MARK: - Private Properties
    
    @State private var isCreateFormShown = false
    @State private var locationFilter = ""
    
    // MARK: - View Body
    
    var body: some View {
        NavigationView {
            VStack {
                SearchField(locationFilter: $locationFilter)
                LocationList(locationFilter: $locationFilter)
                CreateLocationNavigationLink(isCreateFormShown: $isCreateFormShown)
            }.navigationTitle("Locations")
            .navigationBarItems(trailing: Button("Add a Location", action: {
                isCreateFormShown.toggle()
            }))
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .modifier(AppServices())
    }
}

fileprivate struct CreateLocationNavigationLink: View {
    @Binding var isCreateFormShown: Bool
    
    var body: some View {
        NavigationLink(
            destination: CreateLocationView(isViewShown: $isCreateFormShown),
            isActive: $isCreateFormShown,
            label: {
                EmptyView()
            })
    }
}

fileprivate struct SearchField: View {
    @Binding var locationFilter: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $locationFilter)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }.padding(.horizontal)
    }
}

fileprivate struct LocationList: View {
    @EnvironmentObject private var locationService: LocationService
    @Binding var locationFilter: String
    
    var body: some View {
        List {
            ForEach(locationService.locations.items.filter({ (location) -> Bool in
                location.label.contains(locationFilter) || locationFilter == ""
            }), id: \.label) { location in
                NavigationLink(destination: LocationDetailView(location: location)) {
                    LocationListRow(location: location)
                }
            }.onDelete(perform: delete)
        }.listStyle(PlainListStyle())
    }
    
    private func delete(at offsets: IndexSet) {
        let filteredList = locationService.locations.items.filter({ (location) -> Bool in
            location.label.contains(locationFilter) || locationFilter == ""
        })
        
        offsets.forEach {
            RealmHelper.shared.deleteConvertible(filteredList[$0])
        }
    }
}
