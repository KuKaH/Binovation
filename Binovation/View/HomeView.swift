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
    @State private var selectedBuilding: String = ""
    
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
                ForEach(Array(viewModel.sensorDataByBuilding.keys), id: \.self) { key in
                    Button(key) {
                        selectedBuilding = key
                    }
                }
            } label: {
                HStack {
                    Text(selectedBuilding)
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
        case "Hum_floor1": return "인문관 1층"
        default: return name
        }
    }
}

#Preview {
    HomeView()
}
