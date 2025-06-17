//
//  PushAlertViewModel.swift
//  Binovation
//
//  Created by 홍준범 on 6/12/25.
//

import Foundation
import Combine
import SwiftUI

struct PushAlert: Identifiable, Decodable, Equatable {
    let id = UUID()
    let deviceName: String
    let currentFill: Double
    let message: String
    let date: Date  // 없지만 UI 구분용으로 현재 시간 기준 생성

    enum CodingKeys: String, CodingKey {
        case deviceName = "device_name"
        case currentFill = "current_fill"
        case message
        case date = "created_at"
    }

//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.deviceName = try container.decode(String.self, forKey: .deviceName)
//        self.currentFill = try container.decode(Double.self, forKey: .currentFill)
//        self.message = try container.decode(String.self, forKey: .message)
//        self.date = Date() // 서버에 날짜 없으므로 수신 시점으로 처리
//    }

    var building: String {
        if deviceName.contains("Lib") { return "도서관" }
        if deviceName.contains("Human") { return "인문관" }
        if deviceName.contains("Cyber") { return "사이버관" }
        if deviceName.contains("Sci") { return "사과관" }
        if deviceName.contains("EDU") { return "교개원" }
        return "기타"
    }

    var floor: String {
        if let match = deviceName.split(separator: "floor").last {
            return "\(match)층"
        }
        return "-"
    }

    var level: AlertLevel {
        currentFill >= 100 ? .danger : .warning
    }

    enum AlertLevel {
        case warning, danger

        var icon: String {
            switch self {
            case .warning: return "exclamationmark.triangle.fill"
            case .danger: return "exclamationmark.octagon.fill"
            }
        }

        var color: Color {
            switch self {
            case .warning: return .orange
            case .danger: return .red
            }
        }
    }
}

class PushAlertViewModel: ObservableObject {
    static let shared = PushAlertViewModel()
    @Published var alerts: [PushAlert] = []

    private var cancellables = Set<AnyCancellable>()

    func fetchPushAlerts() {
        guard let url = URL(string: "http://3.107.139.2/trash/pushalertslist/") else { return }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [PushAlert].self, decoder: {
                let decoder = JSONDecoder()
                // DateFormatter로 대체
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"  // ISO와 호환
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")  // ✅ 이게 드디어 잘 적용됨

                    decoder.dateDecodingStrategy = .formatted(formatter)
                    return decoder
            }())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("❌ 푸시 알림 로딩 실패: \(error)")
                }
            }, receiveValue: { [weak self] data in
                print(data)
                self?.alerts = data.sorted { $0.date > $1.date }
            })
            .store(in: &cancellables)
    }

//    var todayAlerts: [PushAlert] {
//        alerts.filter { Calendar.current.isDateInToday($0.date) }
//    }
//
//    var previousAlerts: [PushAlert] {
//        alerts.filter { !Calendar.current.isDateInToday($0.date) }
//    }
}
