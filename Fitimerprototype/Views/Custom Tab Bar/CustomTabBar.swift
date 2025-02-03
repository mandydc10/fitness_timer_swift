//
//  CustomTabBar.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 1/2/2025.
//

import SwiftUI

enum Tabs: Int {
    case workouts = 0
    case exercises = 1
    case timer = 2
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        
        HStack (alignment: .center) {
            
            
            Button {
                // TODO Switch to chats
                selectedTab = .workouts
            } label: {
                
                TabBarButton(buttonText: "My Workouts",
                             imageName: "figure.cross.training",
                             isActive: selectedTab == .workouts)
                
            }
            // To add color asset: .tint(Color("colour name"))
            .tint(.gray)
            
            Button {
                // TODO
                selectedTab = .timer
            } label: {
                
                VStack (alignment: .center, spacing: 4) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    Text("Quick Timer")
                    // To add custom font
//                        .font(Font.tabBar)
                }
            }
            // To add color asset: .tint(Color("colour name"))
            .tint(.blue)
            
            Button {
                // TODO: Switch to contacts
                selectedTab = .exercises
            } label: {
                
                TabBarButton(buttonText: "Library",
                             imageName: "figure.run.square.stack",
                             isActive: selectedTab == .exercises)
                
            }
            // To add color asset: .tint(Color("colour name"))
            .tint(.gray)
        }
        .frame(height:82)
        
        
        
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.workouts))
    }
}
