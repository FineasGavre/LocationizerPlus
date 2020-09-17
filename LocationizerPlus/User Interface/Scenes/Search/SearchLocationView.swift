//
//  SearchLocationView.swift
//  Locationizer
//
//  Created by Fineas Gavre on 16.09.2020.
//  Copyright © 2020 Fineas Gavre. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct SearchLocationView: View {
    
    // MARK: - Private Properties
    
    var location: Location
    
    // MARK: - View Body
    
    var body: some View {
        VStack {
            KFImage(URL(string: location.image ?? "")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(location.label)
                .font(.largeTitle)
            Text(location.address)
            Text("Location: lat. \(location.latitude) / lng. \(location.longitude)")
        }
    }
}
