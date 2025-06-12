//
//  HomeViewModel.swift
//  Binovation
//
//  Created by 홍준범 on 5/20/25.
//

import Foundation
import Combine

struct UrgentBin: Identifiable, Decodable {
    var id: String { device_name }
    let device_name: String
    let current_fill: Double
    let message: String
    
    var parsedLocation: String {
            let building: String
            if device_name.contains("Lib") {
                building = "도서관"
            } else if device_name.contains("Human") {
                building = "인문관"
            } else if device_name.contains("Sci") {
                building = "사과관"
            } else if device_name.contains("Cyber") {
                building = "사이버관"
            } else if device_name.contains("EDU") {
                building = "교개원"
            } else {
                building = "기타"
            }
            
            // floor 추출
            let floorNum = device_name.components(separatedBy: "_floor").last ?? ""
            return "\(building) \(floorNum)층"
        }
}

class HomeViewModel: ObservableObject {
    @Published var topUrgentBins: [UrgentBin] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUrgentBins() {
        guard let url = URL(string: "http://3.107.139.2/trash/emergency/") else {
            print("❌ URL 생성 실패")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [UrgentBin].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("❌ 에러 발생: \(error.localizedDescription)")
                case .finished:
                    print("✅ Home 데이터 받아오기 완료")
                }
            }, receiveValue: { [weak self] bins in
                self?.topUrgentBins = bins
            })
            .store(in: &cancellables)
    }
}
