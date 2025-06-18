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
                user.sendEmailVerification { error in
                    DispatchQueue.main.async {
                        if let error = error {
                            self.message = "エラー"
                            print(error.localizedDescription)
                        } else {
                            self.message = "ログイン成功"
                            self.email = ""
                            self.password = ""
                            self.isSuccess = true
                        }
                        self.isLoading = false
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.message = "予期しないエラーが発生しました。"
                    print("予期しないエラーが発生しました。")
                    self.isLoading = false
                }
            }
        }
    }
 
}
