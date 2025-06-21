//
//  ListViewModel.swift
//  myApp
//
//  Created by tkt on 2025/06/19.
//

import Foundation

class ListViewModel {
    
    var users = [User]()
    
    private var currentIndex = 0
    
    init() {
        self.users = getMockUsers()
    }
    
    private func getMockUsers() -> [User] {
        return [
            User.MOCK_USER1,
            User.MOCK_USER2,
            User.MOCK_USER3,
            User.MOCK_USER4,
        ]
    }
    
    func adjustIndex(isRedo: Bool) {
        if isRedo {
            currentIndex -= 1
        } else {
            currentIndex += 1
        }
    }
    
    func nopeButtonTapped() {
        if currentIndex >= users.count { return }
        
        NotificationCenter.default.post(name: Notification.Name("NOPEACTION"), object: nil, userInfo: [
            "id": users[currentIndex].id
        ])
    }
    
    func likeButtonTapped(likeViewModel: LikeViewModel) {
        if currentIndex >= users.count { return }
        
        let currentUser = users[currentIndex]
        
        if let userId = Int(currentUser.id) {
            likeViewModel.sendLike(seijikaId: userId)
        }
        
        NotificationCenter.default.post(name: Notification.Name("LIKEACTION"), object: nil, userInfo: [
            "id": currentUser.id
        ])
    }
    
    func redoButtonTapped() {
        if currentIndex <= 0 { return }
        
        NotificationCenter.default.post(name: Notification.Name("REDOACTION"), object: nil, userInfo: [
            "id": users[currentIndex - 1].id
        ])
    }
    
    func tappedhandler(action: Action, likeViewModel: LikeViewModel) {
        switch action {
        case .nope, .like:
            if currentIndex >= users.count { return }
        case .redo:
            if currentIndex <= 0 { return }
        }
        
        if action == .like && currentIndex < users.count {
            let currentUser = users[currentIndex]
            if let userId = Int(currentUser.id) {
                likeViewModel.sendLike(seijikaId: userId)
            }
        }
        
        NotificationCenter.default.post(name: Notification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": action == .redo ? users[currentIndex - 1].id : users[currentIndex].id,
            "action": action
        ])
    }
}
