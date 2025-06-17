//
//  LoginView.swift
//  myApp
//
//  Created by 安野巧真 on 2025/06/17.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                CustomTextField(
                    placeholder: "メールアドレス",
                    text: $email
                )
                CustomSecureField(
                    placeholder: "パスワード",
                    text: $password
                )
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: handleLogin) {
                    Text("ログイン")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(!email.isEmpty && !password.isEmpty ? Color.blue : Color.gray)
                        .cornerRadius(8)
                }
                .disabled(!email.isEmpty && !password.isEmpty)
                Button(action: handleLogin) {
                    Text("アカウントをお持ちでない方")
                        .font(.subheadline)
                        .foregroundStyle(.blue)
                }
            }
            .padding(.bottom, 32)
        }
        .padding(.horizontal, 20)
        .padding(.top, 32)
    }
    
    private func handleLogin() {
        // ログインよろしくまおと
    }
    
    private func handleRegister() {
        // Registerに移動するのを後々書く
    }
}

#Preview {
    LoginView()
}
