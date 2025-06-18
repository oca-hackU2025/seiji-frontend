//
//  RegisterViewModel.swift
//  myApp
//
//  Created by kmjak on 2025/06/18.
//

import Foundation
import FirebaseAuth
import Combine

class RegisterViewModel: ObservableObject {
    @Published var message: String = ""
    @Published var isSuccess: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirm: String = ""
    @Published var isLoading: Bool = false
    var isSubmit: Bool {
        !email.isEmpty && password == passwordConfirm && !password.isEmpty
    }
    
    func register() {
        guard isSubmit else { return }
        
        isLoading = true
        message = ""
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.message = "登録エラー"
                    print(error.localizedDescription)
                    self.isLoading = false
                }
            } else if let user = result?.user {
                user.sendEmailVerification { error in
                    DispatchQueue.main.async {
                        if let error = error {
                            self.message = "確認メール送信エラー"
                            print(error.localizedDescription)
                        } else {
                            self.message = "登録成功！確認メールを送信しました。メールを確認してください。"
                            self.email = ""
                            self.password = ""
                            self.passwordConfirm = ""
                            self.isSuccess = true
                        }
                        self.isLoading = false
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.message = "予期しないエラーが発生しました。"
                    print("Unexpected error occurred.")
                    self.isLoading = false
                }
            }
        }
    }
}
