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
    @StateObject private var homeVM = HomeViewModel()
    
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
                    
                    ForEach(homeVM.topUrgentBins) { bin in
                        EmergencyBinCardView(
                            floor: bin.parsedLocation,
                            percent: Int(bin.current_fill),
                            message: bin.message
                        )
                    }
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(16)
            }
            .padding(.horizontal)
        }
        .onAppear {
            homeVM.fetchUrgentBins()
        }
        .refreshable {
            homeVM.fetchUrgentBins()
        }
    }
}

//#Preview {
//    HomeView()
//}
