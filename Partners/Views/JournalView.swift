//
//  JournalView.swift
//  Partners
//
//  Created by Andrew Nielson on 8/15/24.
//

import SwiftUI

struct JournalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isCreatePresented = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(MockData.posts) {
                        PostView(post: $0, screenWidth: UIScreen.main.bounds.size.width - 75)
                            .padding()
                    }
                }
                .background(Color(hex: 0xF6E9C7))
                .navigationBarTitle("", displayMode: .inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Journal")
                            .font(.system(size: 35))
                            .bold()
                            .foregroundStyle(Color(hex: 0x152224))
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button{
                                isCreatePresented = true
                            } label:{
                                Image(systemName: "plus.square.fill")
                                    .foregroundStyle(Color(hex: 0x152224))
                                    .fontWeight(.bold)
                                    .imageScale(.large)
                                    .font(.system(size: 30))
                            }
                            
                            Button{
                                dismiss()
                            } label:{
                                Image(systemName: "arrow.down.circle.fill")
                                    .foregroundStyle(Color(hex: 0x152224))
                                    .fontWeight(.bold)
                                    .imageScale(.large)
                                    .font(.system(size: 30))
                            }
                            
                        }
                    }
                })
            }
            .fullScreenCover(isPresented: $isCreatePresented) {
                CreateView()
            }
        }
    }
}

#Preview {
    JournalView()
}
