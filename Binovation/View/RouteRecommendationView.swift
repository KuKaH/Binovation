//
//  RouteRecommendationView.swift
//  Binovation
//
//  Created by 홍준범 on 5/13/25.
//

import SwiftUI

struct RouteRecommendationView: View {
    @State private var selectedBuilding: String = ""
    private let buildings = ["사회과학관", "도서관", "사이버관", "인문과학관", "교수개발원"]
    
    let buildingPositions: [String: CGPoint] = [
        "사회과학관": CGPoint(x: 105, y: 200),
        "도서관": CGPoint(x: 215, y: 215),
        "사이버관": CGPoint(x: 280, y: 205),
        "인문관": CGPoint(x: 75, y: 8),
        "교수개발원": CGPoint(x: 120, y: -15)
    ]
    
    @StateObject private var viewModel = RouteViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("동선 추천")
                    .font(.notoSans(size: 20))
                    .bold()
                    .padding(.top)
                
                HStack {
                    Image(systemName: "figure.walk")
                        .foregroundStyle(.blue)
                    Text("최적 동선을 추천드립니다!")
                        .font(.headline)
                        .foregroundStyle(Color.blue)
                    
                    Spacer()
                }
                .padding(.leading)
                
                if let route = viewModel.route {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("추천 동선")
                                .bold()
                            Spacer()
                            Text(route.recommended_route)
                        }
                        
                        Text("예상 소요시간: \(route.estimated_time)")
                        Text("처리해야 할 쓰레기통 개수: \(route.total_bins)개")
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("세부사항").bold()
                            ForEach(route.details, id: \.self) { detail in
                                Text(detail)
                            }
                        }
                    }
                    .font(.subheadline)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal, 10)
                }
                
                //드롭다운
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Button(action: {
                            if !selectedBuilding.isEmpty {
                                print("선택된 건물: \(selectedBuilding)")
                                viewModel.fetchRoute(for: selectedBuilding)
                            }
                        }) {
                            Text("동선 추천 받기")
                                .font(.notoSans(size: 16))
                        }
                        .buttonStyle(.borderedProminent)
                        .frame(width: 150, height: 50)
                    }
                    
                    BuildingDropdown(selectedBuilding: $selectedBuilding,
                                     buildings: buildings,
                                     placeholder: "현재 위치를 선택해주세요."
                    )
                    .padding(.bottom)
                }
                
                ZStack {
                    Image("HUFSMiniMap")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                    
                    ForEach(Array(viewModel.route?.buildingSequence.enumerated() ?? [].enumerated()), id: \.offset) { index, building in
                        if let position = buildingPositions[building] {
                            MarkerView(index: index)
                                .position(x: position.x, y: position.y)
                        }
                    }
                }
                .frame(height: 300)
            }
            .padding(.bottom, 80)
        }
    }
}

struct DropPin: Shape {
    var startAngle: Angle = .degrees(180)
    var endAngle: Angle = .degrees(0)
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addCurve(to: CGPoint(x: rect.minX, y: rect.midY),
                      control1: CGPoint(x: rect.midX, y: rect.maxY),
                      control2: CGPoint(x: rect.minX, y: rect.midY + rect.height / 4))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.addCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                      control1: CGPoint(x: rect.maxX, y: rect.midY + rect.height / 4),
                      control2: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

struct MarkerView: View {
    let index: Int
    
    var body: some View {
        ZStack {
            // 마커 도형 (배경)
            DropPin()
                .fill(Color.yellow)
                .shadow(radius: 3)
            
            // 가운데 원 + 테두리 + 숫자
            Circle()
                .fill(Color.yellow)
                .frame(width: 24, height: 24)
                .overlay(
                    Circle().stroke(Color.black, lineWidth: 2)
                )
                .overlay(
                    Text("\(index + 1)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                )
                .offset(y: -2) // 위로 살짝 올려서 중앙에 배치
        }
        .frame(width: 35, height: 45)
    }
}

//#Preview {
//    RouteRecommendationView()
//}
