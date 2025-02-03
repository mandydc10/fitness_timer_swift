//
//  TabBarButton.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 2/2/2025.
//

import SwiftUI

struct TabBarButton: View {
    
    var buttonText: String
    var imageName: String
    var isActive: Bool
    
    var body: some View {
        
        GeometryReader { geo in
            
            if isActive {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geo.size.width/2, height: 4)
                    .padding(.leading, geo.size.width/4)
            }
            
            VStack (alignment: .center, spacing: 4) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text(buttonText)
                // To add custom font
                //                        .font(Font.tabBar)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(buttonText: "Workouts", imageName: "figure.cross.training", isActive: true)
    }
}
