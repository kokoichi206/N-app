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
            .padding(.top, 8)
        }
    }
    
    func SortedSchedules(schedules: [Schedule]) -> [Schedule] {
        schedules.sorted(by: { $0.start_time < $1.start_time})
    }

    func OnePerson(schedule: Schedule) -> some View {
        ZStack {
            Color(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.1).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center) {
                    HStack {
                        Text(schedule.cate)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 10)
                            .foregroundColor(.white)
                            .font(.system(size: 10, weight: .bold))
                            .background(.orange)
                        Spacer()
                        Text(schedule.date)
                            .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.1))
                            .font(.system(size: 8, weight: .regular))
                    }
                    .padding(.all, 6)
                HStack {
                    Text(schedule.title)
                        .font(.caption)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.bottom, 8)
            }
            .padding(2)
        }
        .cornerRadius(4)
        .padding(.horizontal, 5)
    }
}

struct ScheduleListView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleListView()
    }
}
