//
//  HomeViewModel.swift
//  Binovation
//
//  Created by 홍준범 on 5/20/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var topUrgentBins: [SensorData] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(sensorViewModel: SensorViewModel) {
        sensorViewModel.$sensorDataByBuilding
            .map { dict in
                dict.flatMap { $0.value }
                    .filter { $0.fill_percent >= 80 }
                    .sorted(by: { $0.fill_percent > $1.fill_percent })
                    .prefix(6)
            }
            .map(Array.init)
            .receive(on: DispatchQueue.main)
            .assign(to: &$topUrgentBins)
    }
}
