//
//  TrashButtonView.swift
//  Binovation
//
//  Created by 홍준범 on 4/8/25.
//

import Foundation
import SwiftUI

struct TrashButtonView: View {
    let color: Color
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "trash.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(color)
            
            Text(label)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.black)
        }
        .frame(width: 140, height: 140)
        .background(Color.white)
        .cornerRadius(16) // predicate
        .shadow(color: Color.gray.opacity(0.25), radius: 4, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}
