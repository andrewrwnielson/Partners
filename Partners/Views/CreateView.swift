//
//  CreateView.swift
//  Partners
//
//  Created by Andrew Nielson on 8/16/24.
//

import SwiftUI
import PhotosUI

struct CreateView: View {
    @Environment(\.dismiss) var dismiss
    let screenWidth = UIScreen.main.bounds.width - 75
    @FocusState private var isCaptionFocused: Bool
    @State private var caption: String = ""
    @State private var pickerItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.down.circle.fill")
                    .foregroundStyle(Color(hex: 0xF6E9C7))
                    .fontWeight(.bold)
                    .imageScale(.large)
                    .font(.system(size: 30))
                    .padding()
                
                Spacer()
                
                Text("New Post")
                    .bold()
                    .font(.title)
                    .foregroundStyle(Color(hex: 0x152224))
                
                Spacer()
                
                Button{
                    dismiss()
                } label:{
                    Image(systemName: "arrow.down.circle.fill")
                        .foregroundStyle(Color(hex: 0x152224))
                        .fontWeight(.bold)
                        .imageScale(.large)
                        .font(.system(size: 30))
                        .padding()
                }
            }
            
            ZStack {
                Rectangle()
                    .frame(width: screenWidth, height: screenWidth * 1.1 + 100)
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                
                VStack(spacing: 0) {
                    if let image = selectedImage {
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: screenWidth - 20, height: screenWidth * 1.1 - 20)
                                .clipped()
                                .offset(y: -10)
                            
                            Button(action: {
                                selectedImage = nil
                            }, label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(.white)
                                        .offset(y: -10)
                                    Image(systemName: "x.square.fill")
                                        .foregroundStyle(.red)
                                        .fontWeight(.bold)
                                        .imageScale(.large)
                                        .font(.system(size: 30))
                                        .padding()
                                        .offset(y: -10)
                                }
                            })
                        }
                    } else {
                        PhotosPicker(selection: $pickerItem, matching: .images) {
                            ZStack {
                                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                    .frame(width: screenWidth - 20, height: screenWidth * 1.1 - 20)
                                    .foregroundStyle(.white)
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 75)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .onChange(of: pickerItem) { newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    selectedImage = Image(uiImage: uiImage)
                                }
                            }
                        }
                        .border(.gray, width: 10)
                        .offset(y: -10)
                    }
                    
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $caption)
                            .focused($isCaptionFocused)
                            .font(.custom("Bradley Hand Bold", size: 20))
                            .keyboardType(.alphabet)
                            .disableAutocorrection(true)
                            .frame(width: screenWidth - 20, height: 80)
                        
                        if caption.isEmpty {
                            Text("Enter a caption")
                                .foregroundColor(.gray)
                                .font(.custom("Bradley Hand Bold", size: 20))
                                .onTapGesture {
                                    isCaptionFocused = true
                                }
                                .offset(x: 5, y: 8)
                        }
                    }
                    .onTapGesture {
                        isCaptionFocused = true
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                // TODO: Create a post object with data from new post
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: screenWidth, height: 75)
                        .foregroundStyle(Color(hex: 0x152224))
                    Text("Post")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                }
            })
            
            Spacer()
        }
        .background(Color(hex: 0xF6E9C7))
    }
}

#Preview {
    CreateView()
}
