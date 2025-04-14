//
//  LibraryView.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation
import SwiftUI
import Combine

struct HomeView: View {
    @StateObject private var viewModel = SensorViewModel()
    @State private var selectedBuildingIndex: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Binovation")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Button(action: {
                    print("설정 버튼 눌림")
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                        .foregroundStyle(.primary)
                }
            }
            
            Text("한국외국어대학교")
                .font(.title)
                .bold()
            
            Text("근무지")
                .font(.headline)
            
            Menu {
                ForEach(0..<buildingList.count, id: \.self) { index in
                    Button(buildingList[index].name) {
                        selectedBuildingIndex = index
                    }
                }
            } label: {
                HStack {
                    Text(buildingList[selectedBuildingIndex].name)
                        .foregroundStyle(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding()
                .background(Color(red: 225/255, green: 230/255, blue: 255/255))
                .cornerRadius(10)
            }
            
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(buildingList[selectedBuildingIndex].floors, id: \.name) { floor in
                        SensorStatusRowView(floorName: floor.name, capacity: floor.capacity)
                    }
                }
                .padding(.top)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
