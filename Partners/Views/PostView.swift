//
//  PostView.swift
//  Partners
//
//  Created by Andrew Nielson on 8/15/24.
//

import SwiftUI

struct PostView: View {
    
    @State private var hasLiked: Bool
    var post: Post
    let screenWidth: CGFloat
    
    init(post: Post, screenWidth: CGFloat) {
        self.post = post
        self.screenWidth = screenWidth
        _hasLiked = State(initialValue: post.hasLiked)
    }

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: screenWidth, height: screenWidth * 1.1 + 100)
                .foregroundStyle(.white)
                .shadow(radius: 10)
            
            VStack {
                
                //Post info.
                
                //Image.
                Image(post.postImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenWidth - 20, height: screenWidth * 1.1 - 20)
                    .clipped()
                
                //Operations menu.
                HStack {
                    Button(action: {
                        
                        self.hasLiked.toggle()
                    }, label: {
                        ZStack {
                            image(Image(systemName: "heart.fill"), show: hasLiked)
                                .padding(5)
                                .padding(.leading, 10)
                            image(Image(systemName: "heart"), show: !hasLiked)
                                .padding(5)
                                .padding(.leading, 10)
                        }
                    })
                    
                    Image(systemName: "bubble.right")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(5)
                    
                    Spacer()
                    
                    Text(post.location)
                        .foregroundStyle(Color(hex: 0x6A8A7D))
                        .font(.custom("Bradley Hand Bold", size: 20))
                        .padding(5)
                        .padding(.trailing, 10)
                }
                .frame(height: 20)
                .padding(.horizontal)
                VStack(alignment: .leading, spacing: 2){
                    Text(post.user.userName)
                        .font(.custom("Bradley Hand Bold", size: 14))
                        .padding(.horizontal, 10)
                    
                    Rectangle()
                        .frame(width: 100, height: 1)
                        .padding(.horizontal, 10)
                    
                    Text(post.caption)
                        .font(.custom("Bradley Hand Bold", size: 14))
                        .padding(.horizontal, 10)
                }
                .frame(maxWidth: screenWidth, maxHeight: 60, alignment: .leading)
            }
            .foregroundStyle(Color(hex: 0x152224))
            .padding(.vertical)
        .foregroundStyle(.white)
        }
    }
    
    func image(_ image: Image, show: Bool) -> some View {
        image
            .tint(hasLiked ? Color(hex: 0xE62013) : Color(hex: 0x152224))
            .frame(width: 15, height: 15)
            .scaleEffect(show ? 1 : 0)
            .opacity(show ? 1 : 0)
            .animation(.interpolatingSpring(stiffness: 170, damping: 15), value: show)
    }
}

#Preview {
    PostView(post: MockData.posts.first!, screenWidth: UIScreen.main.bounds.width - 50)
}
