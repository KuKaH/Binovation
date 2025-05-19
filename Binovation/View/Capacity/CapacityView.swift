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
                    .font(.headline)
                    .bold()
            
                Spacer()
            }
            
            Text("한국외국어대학교")
                .font(.title2)
                .bold()
            
//            Text("근무지")
//                .font(.headline)
//                .padding(.horizontal, 8)
//                .padding(.vertical, -12)
            
            BuildingDropdown(selectedBuilding: $selectedBuilding, buildings: Array(viewModel.sensorDataByBuilding.keys))
            
            ScrollView {
                VStack(spacing: 50) {
                    Spacer(minLength: 0)
                    
                    if let sensors = viewModel.sensorDataByBuilding[selectedBuilding] {
                        ForEach(sensors) { sensor in
                            SensorStatusRowView(
                                floorName: convertDeviceNameToLabel(sensor.device_name),
                                capacity: sensor.fill_percent
                            )
                        }
                    } else {
                        Text("해당 건물에 대한 데이터가 없습니다.")
                            .foregroundStyle(.gray)
                            .frame(maxWidth: .infinity)
                    }
                }
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
    
    func convertDeviceNameToLabel(_ name: String) -> String {
        switch name {
        case "Lib_floor1": return "도서관 1층"
        case "Lib_floor2": return "도서관 2층"
        case "Lib_floor3": return "도서관 3층"
        case "Lib_floor4": return "도서관 4층"
        case "Lib_floor5": return "도서관 5층"
        case "Human_floor1": return "인문관 1층"
        case "Human_floor2": return "인문관 2층"
        case "Human_floor3": return "인문관 3층"
        case "Human_floor4": return "인문관 4층"
        case "Human_floor5": return "인문관 5층"
        case "Human_floor6": return "인문관 6층"
        case "SocSci_floor1": return "사과관 1층"
        case "SocSci_floor2": return "사과관 2층"
        case "SocSci_floor3": return "사과관 3층"
        case "SocSci_floor4": return "사과관 4층"
        case "SocSci_floor5": return "사과관 5층"
        case "SocSci_floor6": return "사과관 6층"
        case "Lib_floor_test": return "테스트 1층"
        default: return name
        }
    }
}

#Preview {
    CapacityView()
}
