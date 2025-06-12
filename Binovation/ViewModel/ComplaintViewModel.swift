import Foundation
import Combine

struct Complaint: Identifiable, Decodable, Equatable {
    let id: Int
    let building: String
    let floor: Int
    let content: String
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id, building, floor, content
        case createdAt = "created_at"
    }
}

extension JSONDecoder.DateDecodingStrategy {
    static var iso8601withFractionalSeconds: JSONDecoder.DateDecodingStrategy {
        .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            
            if let date = formatter.date(from: dateStr) {
                return date
            }
            
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "날짜 파싱 실패: \(dateStr)")
        }
    }
}

class ComplaintViewModel: ObservableObject {
    static let shared = ComplaintViewModel()
    @Published var complaints: [Complaint] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchComplaints() {
        guard let url = URL(string: "http://3.107.139.2/trash/complaintlist/") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Complaint].self, decoder: {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601withFractionalSeconds
                return decoder
            }())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print("📡 민원 API 응답 상태: \(completion)")
            }, receiveValue: { [weak self] data in
                self?.complaints = data.sorted { $0.createdAt > $1.createdAt }
            })
            .store(in: &cancellables)
    }
    
    func clearAllComplaints() {
        guard let url = URL(string: "http://3.107.139.2/trash/alerts/clear/complaint") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode == 204 else {
                    throw URLError(.badServerResponse)
                }
                return ()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("❌ 민원 전체 삭제 실패: \(error)")
                }
            }, receiveValue: { [weak self] in
                self?.complaints.removeAll()
                print("✅ 민원 전체 삭제 완료")
            })
            .store(in: &cancellables)
    }
    
    var today: [Complaint] {
        complaints.filter { Calendar.current.isDateInToday($0.createdAt) }
    }
    
    var previous: [Complaint] {
        complaints.filter { !Calendar.current.isDateInToday($0.createdAt) }
    }
}

extension ComplaintViewModel {
    /// 주어진 조건의 서브 리스트에서 인덱스에 해당하는 complaint를 찾아 원본 리스트에서 제거
    func delete(filter: (Complaint) -> Bool, at indexSet: IndexSet) {
        let filteredList = complaints.enumerated().filter { filter($0.element) }
        
        for index in indexSet {
            if let originalIndex = filteredList[safe: index]?.offset {
                complaints.remove(at: originalIndex)
            }
        }
    }
}

// 안전한 인덱스 접근 확장
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
