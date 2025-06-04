//
//  RouteViewModel.swift
//  Binovation
//
//  Created by 홍준범 on 6/3/25.
//

import Foundation
import Combine

class RouteViewModel: ObservableObject {
    @Published var route: RouteData?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    let fetchTrigger = PassthroughSubject<String, Never>()
    
    private let buildingCodeMap: [String: String] = [
        "도서관": "Lib_floor1",
        "사회과학관": "SocSci_floor1",
        "인문과학관": "Human_floor1",
        "사이버관": "Cyber_floor1",
        "교수개발원": "EDU_floor1"
    ]
    
    init() {
        bind()
    }
    
    private func bind() {
        fetchTrigger
            .handleEvents(receiveOutput: { building in
                print("api 요청시작 : \(building)")
                self.isLoading = true
                self.errorMessage = nil
            })
            .flatMap { buildingName -> AnyPublisher<RouteData, Error> in
                guard let code = self.buildingCodeMap[buildingName] else {
                    return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
                }
                
                let urlString = "http://3.107.139.2/trash/route/\(code)"
                guard let url = URL(string: urlString) else {
                    return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
                }
                
                return URLSession.shared.dataTaskPublisher(for: url)
                    .handleEvents(receiveOutput: { data, _ in
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("📦 API 응답 JSON:\n\(jsonString)")
                        } else {
                            print("❌ 응답 데이터를 문자열로 변환 실패")
                        }
                    })
                    .map(\.data)
                    .decode(type: RouteData.self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                    print("api 실패: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] data in
                print("api 응답성공: \(data)")
                self?.route = data
            })
            .store(in: &cancellables)
    }
    
    func fetchRoute(for buildingName: String) {
        fetchTrigger.send(buildingName)
    }
}

struct RouteData: Codable {
    let recommended_route: String
    let estimated_time: String
    let total_bins: Int
    let details: [String]
    
    var buildingSequence: [String] {
        recommended_route.components(separatedBy: " → ")
    }
}
