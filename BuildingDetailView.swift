//
//  BuildingDetailView.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import SwiftUI

struct BuildingDetailView: View {
    let buildingName: String
    let floorData: [(name: String, capacity: Int)]
                    
    var body: some View {
        Spacer()
        
        ScrollView {
            VStack(spacing: 40) {
                ForEach(floorData, id: \.name) { data in
                    SensorStatusRowView(floorName: data.name, capacity: data.capacity)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .navigationTitle(buildingName)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(red: 245/255, green: 245/255, blue: 250/255))
    }
}

//#Preview {
//    BuildingDetailView()
//}
