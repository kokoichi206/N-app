//
//  BaseView.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/22.
//

import SwiftUI

struct BaseView: View {
    // Using Image Names as Tab...
    @State var currentTab = "person.text.rectangle"
    
    // Hiding Native One..
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            // Tab View..
            TabView(selection: $currentTab) {
                
                MemberListView()
                    .tag("text.bubble")
                
                Text("Blog")
                    .tag("newspaper")
                
                Text("Schedule")
                    .tag("calendar")
             
                Text("Formation")
                    .tag("person.3.fill")
                
                Text("Settings")
                    .tag("gearshape.fill")
            }
            
            // Custom Tab Bar...
            HStack(spacing: 40) {
                
                // Tab Buttons...
                TabButton(image: "person.text.rectangle")
                TabButton(image: "newspaper")
                TabButton(image: "calendar")
                TabButton(image: "person.3.fill")
                TabButton(image: "gearshape.fill")
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
        }
    }
    
    @ViewBuilder
    func TabButton(image: String) -> some View {
        
        Button {
            withAnimation {
                currentTab = image
            }
        } label: {
            Image(systemName: image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(
                
                    currentTab == image ? Color.gray.opacity(1.0) : Color.gray.opacity(0.4)
                )
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}