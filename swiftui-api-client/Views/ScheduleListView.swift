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
                                MainList(schedules: SortedSchedules(schedules: schedules))

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
            LazyVStack {
                ForEach((0..<schedules.count), id: \.self) { index in
                    OnePerson(schedule: schedules[index])
                }
            }
        }
    }
    
    func SortedSchedules(schedules: [Schedule]) -> [Schedule] {
        schedules.sorted(by: { $0.start_time < $1.start_time})
    }

    func OnePerson(schedule: Schedule) -> some View {
        VStack(alignment: .center) {
                HStack {
                    Text(schedule.cate)
                        .foregroundColor(Color(red: 0, green: 0, blue: 1))
                        .font(.system(size: 8, weight: .regular))
                    .padding(.bottom, 4.0)
                    Spacer()
                }
                .padding(.leading, 5.0)
            HStack {
                Text("\(schedule.start_time)~\(schedule.end_time)")
                    .font(.system(size: 12, weight: .regular))
                .padding(.bottom, 4.0)
                Spacer()
            }
            .padding(.leading, 5.0)
            HStack {
                Text(schedule.title)
                    .font(.caption)
                Spacer()
            }
            .padding(.leading, 5.0)
        }
        .padding(2)
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView()
    }
}
