//
//  BinovationSplashView.swift
//  Binovation
//
//  Created by 홍준범 on 5/20/25.
//

import SwiftUI

struct BinovationSplashView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color(hex: "#2A3D50")
                    .ignoresSafeArea()
                
                HStack(spacing: 0) {
                    Text("Bi")
                        .font(.madimiOne(size: 36))
                        .foregroundStyle(.white)
                    
                    Image(systemName: "trash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                    
                    Text("ovation")
                        .font(.madimiOne(size: 36))
                        .foregroundStyle(.white)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5 ) {
                    withAnimation {
                        isActive = false
                    }
                }
            }
        }
    }
}

#Preview {
    BinovationSplashView()
}
