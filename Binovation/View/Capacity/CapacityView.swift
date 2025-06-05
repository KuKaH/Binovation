//
//  CapacityView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import Foundation
import SwiftUI
import Combine

struct CapacityView: View {
    @StateObject private var viewModel = SensorViewModel()
    @State private var selectedBuilding: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                
                Text("Binovation")
                    .font(.notoSans(size: 20))
                    .bold()
            
                Spacer()
            }
            
            Text("한국외국어대학교")
                .font(.title2)
                .bold()
            
            BuildingDropdown(selectedBuilding: $selectedBuilding, buildings: Array(viewModel.sensorDataByBuilding.keys))
            
            ScrollView {
                VStack(spacing: 50) {
                    if let sensors = viewModel.sensorDataByBuilding[selectedBuilding] {
                        ForEach(sensors) { sensor in
                            SensorStatusRowView(
                                floorName: SensorNameParser.fullLabel(from: sensor.device_name),
                                capacity: sensor.fill_percent
                            )
                        }
                    } else {
                        Text("해당 건물에 대한 데이터가 없습니다.")
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.top, 16)
            }
            .refreshable {
                print("Pull to Refresh triggered")
                viewModel.fetchSensorDate()
            }
            
            Spacer()
        }
        .padding()
        .onChange(of: viewModel.sensorDataByBuilding) { newData in
            if selectedBuilding.isEmpty, let firstKey = newData.keys.first {
                selectedBuilding = firstKey
            }
        }
    }
}

#Preview {
    CapacityView()
}
