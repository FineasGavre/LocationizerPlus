//
//  AppServices.swift
//  LocationizerPlus
//
//  Created by Fineas Gavre on 16.09.2020.
//

import SwiftUI

struct AppServices: ViewModifier {
    
    // MARK: - Private State Objects
    
    @StateObject private var locationService = LocationService()

    // MARK: - Modifier Body
    
    func body(content: Content) -> some View {
        content
            .environmentObject(locationService)
    }
}
