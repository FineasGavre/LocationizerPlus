//
//  LocationListRow.swift
//  Locationizer
//
//  Created by Fineas Gavre on 15.09.2020.
//  Copyright © 2020 Fineas Gavre. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct LocationListRow: View {
    
    @EnvironmentObject private var locationService: LocationService
    let location: Location
    
    var body: some View {
        HStack {
            KFImage(URL(string: location.image ?? "https://via.placeholder.com/150x150"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .center)
            VStack(alignment: .leading) {
                Text(location.label)
                    .bold()
                Text(location.address)
                Text("\(locationService.getUserDistanceToLocation(location: location) ?? -1) km")
            }
        }
    }
}
