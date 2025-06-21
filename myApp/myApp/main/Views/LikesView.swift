//
//  LikesView.swift
//  myApp
//
//  Created by tkt on 2025/06/20.
//

import SwiftUI

struct LikesView: View {
    @StateObject private var likeViewModel = LikeViewModel()
    @State private var selectedUser: User? = nil
    @State private var isModalPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            // HeaderText
            headerText
            
            // Loading状態
            if likeViewModel.isLoading {
                Spacer()
                ProgressView("読み込み中...")
                Spacer()
            } else if likeViewModel.likedUsers.isEmpty {
                // いいねしたユーザーがいない場合
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: "heart.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("いいねしたユーザーはいません")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                Spacer()
            } else {
                // Grid
                likesGrid
                Spacer()
            }
        }
        .background(.white)
        .overlay(
            // モーダル表示
            modalOverlay
        )
        .onAppear {
            likeViewModel.fetchLikedUsers()
        }
        .refreshable {
            likeViewModel.fetchLikedUsers()
        }
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
            
            // 更新ボタン
            Button(action: {
                likeViewModel.fetchLikedUsers()
            }) {
                Image(systemName: "arrow.clockwise")
                    .font(.title3)
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
    
    private var likesGrid: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 2), spacing: 8) {
                ForEach(likeViewModel.likedUsers) { user in
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
                .overlay(
                    // いいねマーク
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                                .background(
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 30, height: 30)
                                )
                        }
                        Spacer()
                    }
                    .padding(8),
                    alignment: .topTrailing
                )
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
