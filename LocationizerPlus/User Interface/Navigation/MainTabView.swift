//
//  MainTabView.swift
//  LocationizerPlus
//
//  Created by Fineas Gavre on 16.09.2020.
//

import SwiftUI

struct MainTabView: View {
    
    // MARK: - State Objects
    
    @State private var selectedTab = 1
    
    // MARK: - View Body
    
    var body: some View {
        TabView(selection: $selectedTab) {
            LocationListView()
                .tabItem {
                    Image(systemName: "mappin")
                    Text("Locations")
                }.tag(1)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.tag(2)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }.tag(3)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
