//
//  LocationDetailView.swift
//  LocationizerPlus
//
//  Created by Fineas Gavre on 16.09.2020.
//

import SwiftUI
import MapKit
import KingfisherSwiftUI

struct LocationDetailView: View {
    
    // MARK: - Public Properties
    
    var location: Location
    
    // MARK: - Private Properties
    
    @State private var isEditFormShown = false
    
    var body: some View {
        ScrollView {
            KFImage(URL(string: location.image ?? "https://via.placeholder.com/150x150"))
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(location.address)
            Text("\(location.latitude) / \(location.longitude)")
            NavigationLink(
                destination: EditLocationDetailView(isViewShown: $isEditFormShown, location: location),
                isActive: $isEditFormShown,
                label: {
                    EmptyView()
                })
        }.navigationBarItems(trailing: Button("Edit") {
            isEditFormShown = true
        }).navigationTitle(location.label)
    }
}
