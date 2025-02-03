//
//  SettingsView.swift
//  Fitimerprototype
//
//  Created by Amanda Cook on 2/2/2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .frame(alignment: .leading)
            List {
                
                // Rate the app
                // TODO: Change url
                let reviewUrl = URL(string: "https://apps.apple.com/app.id6670766958?action=write-review")!
                
                Link(destination: reviewUrl, label: {
                    
                    HStack {
                        Image(systemName: "star.bubble")
                        Text("Rate the app")
                    }
                })
                
                // Recommend the app
                // TODO: Change url
                let shareUrl = URL(string: "https://apps.apple.com/app.id6670766958")!
                
                ShareLink(item: shareUrl) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.right")
                        Text("Recommend the app")
                    }
                }
                
                // Contact
                // TODO: Change path in createMailUrl function
                Button {
                    // Compose email
                    let mailUrl = createMailUrl()
                    
                    if let mailUrl = mailUrl,
                       UIApplication.shared.canOpenURL(mailUrl) {
                        UIApplication.shared.open(mailUrl)
                    }
                    else {
                        print("Couldn't open mail client")
                    }
                } label: {
                    HStack {
                        Image(systemName: "quote.bubble")
                        Text("Submit feedback")
                    }
                }
            
                // Privacy policy
                // TODO: Change url
                let privacyUrl = URL(string: "https://codewithchris.com/abd-privacy-policy/")!
                
                Link(destination: privacyUrl, label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Privacy policy")
                    }
                })
            }
            .listRowSeparator(.hidden)
            .listStyle(.plain)
            .tint(.black)
        }
    }
    
    func createMailUrl() -> URL? {
        
        var mailUrlComponents = URLComponents()
        mailUrlComponents.scheme = "mailto"
        // TODO: Change path
        mailUrlComponents.path = "mandy.dc@gmail.com"
        mailUrlComponents.queryItems = [
            URLQueryItem(name: "subject", value: "Feedback for Fitimer")
        ]
        
        return mailUrlComponents.url
    }
        
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
