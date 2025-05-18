//
//  BuildingDropdown.swift
//  Binovation
//
//  Created by 홍준범 on 5/15/25.
//

import SwiftUI

struct BuildingDropdown: View {
    @Binding var selectedBuilding: String
    let buildings: [String]
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(selectedBuilding.isEmpty ? "장소를 선택해주세요." : selectedBuilding)
                        .foregroundStyle(selectedBuilding.isEmpty ? .gray : .primary)
                        .font(.caption2)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.gray)
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color(hex: "#DDE7F3"))
                .cornerRadius(4)
                .overlay(RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(buildings, id: \.self) { building in
                        Button(action: {
                            selectedBuilding = building
                            withAnimation {
                                isExpanded = false
                            }
                        }) {
                            Text(building)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 12)
                                .font(.caption2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(hex: "#DDE7F3"))
                        }
                        Divider()
                    }
                }
                .background(Color.white)
                .cornerRadius(4)
                .shadow(radius: 4)
            }
        }
        .padding(.horizontal)
    }
}
//
//#Preview {
//    BuildingDropdown()
//}
