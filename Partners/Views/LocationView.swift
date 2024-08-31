//
//  LocationView.swift
//  Partners
//
//  Created by Andrew Nielson on 8/15/24.
//

import SwiftUI

struct LocationView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            MapView()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button{
                        dismiss()
                    } label:{
                        ZStack {
                            Circle()
                                .frame(width: 50)
                                .foregroundStyle(.white)
                            Image(systemName: "arrow.down.circle.fill")
                                .foregroundStyle(Color(hex: 0x002247))
                                .fontWeight(.bold)
                                .imageScale(.large)
                            .font(.system(size: 30))
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LocationView()
}
