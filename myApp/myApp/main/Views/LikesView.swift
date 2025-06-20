//
//  LikesView.swift
//  myApp
//
//  Created by tkt on 2025/06/20.
//

import SwiftUI

struct LikesView: View {
    // 一時的に全ユーザーを取得
    private let likeUsers = [
        User.MOCK_USER1,
        User.MOCK_USER2,
        User.MOCK_USER3,
        User.MOCK_USER4,
        User.MOCK_USER5,
        User.MOCK_USER6,
        User.MOCK_USER7
    ]
    
    @State private var selectedUser: User? = nil
    @State private var isModalPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // HeaderText
            headerText
            
            // Grid
            likesGrid
            
            Spacer()
        }
        .background(.white)
        .overlay(
            // モーダル表示
            modalOverlay
        )
    }
}

#Preview {
    MainView()
}

extension LikesView {
    private var headerText: some View {
        HStack {
            Text("LIKE一覧")
                .font(.title2.bold())
                .foregroundStyle(.black)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    private var likesGrid: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2), spacing: 8) {
                ForEach(likeUsers) { user in
                    posterCard(user: user)
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func posterCard(user: User) -> some View {
        Button(action: {
            selectedUser = user
            withAnimation(.easeInOut(duration: 0.3)) {
                isModalPresented = true
            }
        }) {
            Image("poster_\(user.id)")
                .resizable()
                .frame(height: 250)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private var modalOverlay: some View {
        Group {
            if isModalPresented, let user = selectedUser {
                // 背景の透明な黒
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isModalPresented = false
                        }
                    }
                
                CardView(user: user) { _ in
                // 何もしない(Redoは無効)
                }
                .scaleEffect(0.9)
                .onTapGesture {
                    // カードタップ時は何もしない(閉じない)
                }
            }
        }
    }
}
