//
//  LikeViewModel.swift
//  myApp
//
//  Created by kmjak on 2025/06/20.
//

import Foundation

final class LikeViewModel: ObservableObject {
    @Published var message: String = ""
    @Published var isSuccess: Bool = false
    @Published var isLoading: Bool = false
    @Published var likedUserIds: Set<Int> = []
    @Published var likedUsers: [User] = []
    
    private let allUsers = [
        User.MOCK_USER1,
        User.MOCK_USER2,
        User.MOCK_USER3,
        User.MOCK_USER4,
        User.MOCK_USER5,
        User.MOCK_USER6,
        User.MOCK_USER7
    ]
    
    init() {
        fetchLikedUsers()
    }
    
    func sendLike(seijikaId: Int) {
        isLoading = true
        LikeService.sendLike(seijikaId: seijikaId) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.message = response.message
                    self.isSuccess = true
                    // 成功時にローカルの状態も更新
                    self.likedUserIds.insert(seijikaId)
                    self.updateLikedUsers()
                case .failure(let error):
                    self.message = "エラーが発生しました"
                    self.isSuccess = false
                    print(error)
                }
            }
        }
    }
    
    func fetchLikedUsers() {
        isLoading = true
        LikeService.fetchLikedUsers { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let likedIds):
                    self.likedUserIds = Set(likedIds)
                    self.updateLikedUsers()
                case .failure(let error):
                    self.message = "いいね一覧の取得に失敗しました"
                    self.isSuccess = false
                    print(error)
                }
            }
        }
    }
    
    private func updateLikedUsers() {
        likedUsers = allUsers.filter { user in
            guard let userId = Int(user.id) else { return false }
            return likedUserIds.contains(userId)
        }
    }
    
    func isLiked(userId: String) -> Bool {
        guard let id = Int(userId) else { return false }
        return likedUserIds.contains(id)
    }
}
