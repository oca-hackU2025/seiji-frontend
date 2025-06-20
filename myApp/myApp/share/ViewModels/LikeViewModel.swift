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
    
    func sendLike(politicianId: Int) {
        isLoading = true
        LikeService.sendLike(politicianId: politicianId) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success:
                    self.message = "いいねしました"
                    self.isSuccess = true
                case .failure(let error):
                    self.message = "エラーが発生しました"
                    self.isSuccess = false
                }
            }
        }
    }
}
