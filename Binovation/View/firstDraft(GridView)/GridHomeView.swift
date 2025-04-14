////
////  HomeView.swift
////  Binovation
////
////  Created by 홍준범 on 4/8/25.
////
//
//import Foundation
//import SwiftUI
//
//struct GridHomeView: View {
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Spacer()
//                
//                let columns = [GridItem(.flexible()),
//                               GridItem(.flexible())
//                ]
//                
//                //Grid layout
//                LazyVGrid(columns: columns, spacing: 100) {
//                    NavigationLink(destination: LibraryView()) {
//                        TrashButtonView(color: .red, label: "도서관")
//                    }
//                    NavigationLink(destination: HumanitiesView()) {
//                        TrashButtonView(color: .yellow, label: "인문관")
//                    }
//                    NavigationLink(destination: ScienceView()) {
//                        TrashButtonView(color: .orange, label: "사과관")
//                    }
//                    NavigationLink(destination: EducationView()) {
//                        TrashButtonView(color: .green, label: "교개원")
//                    }
//                }
//                .padding(.horizontal, 30)
//                .padding(.bottom, 40)
//                
//                Spacer()
//            }
//            .background(Color(red: 240/255, green: 240/255, blue: 245/255))
//            .navigationTitle("🗑️ Binovation")
//        }
//    }
//}
//
////#Preview {
////    HomeView()
////}
