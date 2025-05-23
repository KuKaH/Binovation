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
    @StateObject private var sensorVM = SensorViewModel()
    @StateObject private var homeVM: HomeViewModel
    
    init() {
        let sensor = SensorViewModel()
        _sensorVM = StateObject(wrappedValue: sensor)
        _homeVM = StateObject(wrappedValue: HomeViewModel(sensorViewModel: sensor))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Binovation")
                    .font(.spaceGrotesk(size: 20))
                    .bold()
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("긴급 수거가 필요합니다.")
                            .font(.headline)
                            .foregroundStyle(.red)
                        Spacer()
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.red)
                    }
                    
                    ForEach(homeVM.topUrgentBins, id: \.device_name) { bin in
                        let (building, floor) = SensorNameParser.parse(bin.device_name)
                        EmergencyBinCardView(floor: "\(building) \(floor)층", percent: bin.fill_percent, message: bin.fill_percent >= 90 ? "지금 수거하세요!" : "30분 내에\n수거 추천드려요!")
                    }
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(16)
            }
            .padding(.horizontal)
        }
        .refreshable {
            sensorVM.fetchSensorDate()
        }
    }
}

#Preview {
    HomeView()
}
