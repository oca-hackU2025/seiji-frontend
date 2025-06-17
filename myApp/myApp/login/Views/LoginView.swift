//
//  LoginView.swift
//  myApp
//
//  Created by 安野巧真 on 2025/06/17.
//

import SwiftUI

struct LoginView: View {
    @Binding var selection: Int
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                .disabled(email.isEmpty || password.isEmpty)
                
                Button("アカウントをお持ちでない方") {
                    selection = 1
                }
                .font(.subheadline)
                .foregroundStyle(.blue)
            }
            .padding(.bottom, 32)
        }
        .padding(.horizontal, 20)
        .padding(.top, 32)
    }
    
    private func handleLogin() {
        // ログイン処理
    }
}

#Preview {
    LoginView(selection: .constant(0))
}
