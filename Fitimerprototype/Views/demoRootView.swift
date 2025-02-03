//
//  demoRootView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 2/2/2025.
//

import SwiftUI

struct demoRootView: View {
    
    @State var selectedTab: Tabs = .workouts
    
    var body: some View {
        
        VStack {
            
        
            
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
    
    //original
//    TabView {
//        
//        WorkoutListView()
//            .tabItem {
//                Text("My Workouts")
//                Image(systemName: "figure.cross.training")
//            }
//        
//        ExerciseLibraryView()
//            .tabItem {
//                Text("Exercise Library")
//                Image(systemName: "figure.run.square.stack")
//            }
//        RevenueCatView()
//            .tabItem {
//                Text("Premium")
//                Image(systemName: "dollarsign.circle")
//            }
//        SettingsView()
//            .tabItem {
//                Text("Settings")
//                Image(systemName: "gearshape.fill")
//            }
//        
//    }
}

struct demoRootView_Previews: PreviewProvider {
    static var previews: some View {
        demoRootView()
    }
}
