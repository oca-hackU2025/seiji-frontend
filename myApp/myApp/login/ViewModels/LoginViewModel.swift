//
//  LoginViewModel.swift
//  myApp
//
//  Created by 安野巧真 on 2025/06/18.
//

import Foundation
import FirebaseAuth
import Combine

class LoginViewModel: ObservableObject {
    @Published var message: String = ""
    @Published var isSuccess: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    var isSubmit: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    func login() {
        guard isSubmit else { return }
        
        isLoading = true
        message = ""
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.message = "ログインエラー"
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            } else if let user = result?.user {
                user.getIDToken(completion: { token, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            self.message = "トークン取得エラー"
                            print(error.localizedDescription)
                            self.isLoading = false
                        }
                        return
                    }
                    
                    guard let token = token else {
                        DispatchQueue.main.async {
                            self.message = "トークンが空です。"
                            self.isLoading = false
                        }
                        return
                    }
                    AuthService.sendTokenToBackend(token) { result in
                        DispatchQueue.main.async {
                            self.isLoading = false
                            switch result {
                            case .success:
                                self.message = "ログイン成功"
                                self.email = ""
                                self.password = ""
                                self.isSuccess = true
                                print(self.message)
                            case .failure(let error):
                                self.message = "通信エラー: \(error.localizedDescription)"
                                print(self.message)
                            }
                        }
                    }
                })
                
            } else {
                DispatchQueue.main.async {
                    self.message = "予期しないエラーが発生しました。"
                    self.isLoading = false
                }
            }
        }
    }
}
