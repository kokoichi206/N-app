//
//  ScheduleListView.swift
//  swiftui-api-client
//
//  Created by kansai okadome on 2022/03/27.
//

import SwiftUI

struct ScheduleListView: View {
    @StateObject private var viewModel = ScheduleListViewModel()
    
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            NavigationView {
                ZStack {
                    Color.white.edgesIgnoringSafeArea(.all)
                    Group {
                        switch viewModel.schedules {
                        case .idle, .loading:
                            ProgressView("loading...")
                        case let .loaded(schedules):
                            if schedules.isEmpty {
                                Text("something wrong about API.")
                            } else {
                                
                                // MARK: Main List about schedules
                                MainList(schedules: schedules)

                            }
                        case let .failed(error):

                            Text(error.localizedDescription)
                        }
                    }
                    .navigationBarTitle("スケジュール", displayMode: .inline)
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
    
    func DoubleDivider(show: Bool = true) -> some View {
        VStack(spacing: 2) {
            Rectangle()
                .padding(0)
                .foregroundColor(Color.purple)
                .opacity((show ? 1 : 0))
                .frame(height: 2)
            Rectangle()
                .padding(0)
                .foregroundColor(Color.purple)
                .opacity((show ? 1 : 0))
                .frame(height: 2)
        }
    }
    
    func MainList(schedules: [Schedule]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            let width: CGFloat = 100
            LazyVStack {
                ForEach((0..<GetRowNum(schedules: schedules)), id: \.self) { row in
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(0...2, id: \.self) { col in
                            if 3*row+col < schedules.count {
//                                NavigationLink(
//                                    destination: ScheduleDetailView(schedule: schedules[3*row+col])) {
                                        OnePerson(schedule: schedules[3*row+col], width: width)
//                                    }
                            } else {
                                Rectangle()
                                    .frame(width: width)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }
    
    func GetRowNum(schedules: [Schedule]) -> Int {
        let t = schedules.count / 3
        if schedules.count % 3 == 0 {
            return t
        } else {
            return t + 1
        }
    }
    
    func OnePerson(schedule: Schedule, width: CGFloat) -> some View {
        VStack(alignment: .center) {
            // MARK: Face Image
            // MARK: Name
            Text(schedule.title)
                .foregroundColor(Color.purple)
                .font(.caption)
            Text(schedule.date)
                .foregroundColor(Color(red: 0, green: 0, blue: 1))
                .font(.system(size: 8, weight: .regular))
                .padding(.bottom, 4.0)
                
        }
        .padding(2)
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView()
    }
}
