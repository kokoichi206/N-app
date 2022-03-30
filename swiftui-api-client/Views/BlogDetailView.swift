//
//  BlogDetailView.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/27.
//

import SwiftUI

struct BlogDetailView: View {
    let blog: Blog
    
    private let mockBlogs: [Blog] = [
        .mock1
    ]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: blog.img)) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 250, height: 300)
                    .cornerRadius(5)
                    .shadow(color: .gray.opacity(0.7), radius: 5)
                    VStack(alignment: .center) {
                                Text(blog.name)
                                    .font(.largeTitle)
                                    .foregroundColor(Color(red: 0.5, green: 0.1, blue: 0.5, opacity: 0.9))
                            HStack {
                                Text(blog.name)
                                Text(blog.title)
                            }                              .font(.caption2)
                            .foregroundColor(Color(red: 0.7, green: 0.2, blue: 0.7, opacity: 0.4))
                        VStack {
                            HStack {
                                Text(blog.name)
                            }
                            HStack {
                                Text(blog.name)
                            }
                            HStack {
                                Text(blog.name)
                            }
                            HStack {
                                Text(blog.img)
                                Text(blog.text)
                            }
                        }
                    }
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    

                    }
                .padding(8)
            }
            .navigationTitle(blog.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "chevron.backward")
                        }
                    ).tint(.white)
                }
        }
        }
        
    }
}

struct ContentsView: View {
    init() {
        setupNavigationBar()
    }
     
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemPurple
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private let mockBlogs: [Blog] = [
        .mock1
    ]

    var body: some View {
        VStack {
            NavigationView {
                BlogDetailView(blog: .mock1)
            }
        }
    }
}

struct BlogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentsView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
