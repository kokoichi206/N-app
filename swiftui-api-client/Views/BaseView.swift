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
                
                BlogListView()
                    .tag("book")
                
                ScheduleListView()
                    .tag("calendar")
             
                NewsListView()
                    .tag("newspaper")
                
                Text("Formation")
                    .tag("person.3.fill")
                
                Text("Settings")
                    .tag("gearshape.fill")
            }
            
            // Custom Tab Bar...
            HStack(spacing: 20) {
                
                // Tab Buttons...
                TabButton(image: "person.text.rectangle")
                TabButton(image: "book")
                TabButton(image: "calendar")
                TabButton(image: "newspaper")
                TabButton(image: "person.3.fill")
                TabButton(image: "gearshape.fill")
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
            .background(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.9))
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
