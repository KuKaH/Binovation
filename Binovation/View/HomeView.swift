//
//  LibraryView.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var selectedBuildingIndex: Int? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
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
                    Text(selectedBuildingIndex == nil ? "장소를 선택해주세요." : buildingList[selectedBuildingIndex!].name)
                        .foregroundStyle(selectedBuildingIndex == nil ? .gray : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding()
                .background(Color(red: 225/255, green: 230/255, blue: 255/255))
                .cornerRadius(10)
            }
            
            if let index = selectedBuildingIndex {
                ScrollView {
                    VStack(spacing: 30) {
                        ForEach(buildingList[index].floors, id: \.name) { floor in
                            SensorStatusRowView(floorName: floor.name, capacity: floor.capacity)
                        }
                    }
                    .padding(.top)
                }
            } else {
                Spacer()
            }
            
            Spacer()
        }
        .padding()
    }
}
