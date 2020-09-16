//
//  LocationizerPlusApp.swift
//  LocationizerPlus
//
//  Created by Fineas Gavre on 16.09.2020.
//

import SwiftUI

@main
struct LocationizerPlusApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .modifier(AppServices())
        }
    }
}
