//
//  RegisterView.swift
//  myApp
//
//  Created by kmjak on 2025/06/15.
//

import SwiftUI


struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    
    private var passwordsMatch: Bool {
        password == passwordConfirm && !passwordConfirm.isEmpty
    }
    
    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && !passwordConfirm.isEmpty && passwordsMatch
    }
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                CustomTextField (
                    placeholder: "メールアドレス",
                    text: $email
                )
                CustomSecureField (
                    placeholder: "パスワード",
                    text: $password
                )
                CustomSecureField (
                    placeholder: "パスワード確認",
                    text: $passwordConfirm
                )
                if !passwordConfirm.isEmpty && !passwordsMatch {
                    Text("パスワードが一致しません")
                        .foregroundStyle(.red)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button(action: handleRegister) {
                    Text("新規登録")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(isFormValid ? Color.blue : Color.gray)
                        .cornerRadius(8)
                }
                .disabled(!isFormValid)
                Button(action: handleLogin) {
                    Text("すでにアカウントをお持ちの方")
                        .font(.subheadline)
                        .foregroundStyle(.blue)
                }
            }
            .padding(.bottom, 32)
        }
        .padding(.horizontal, 20)
        .padding(.top, 32)
    }
    
    private func handleRegister() {
        // 登録処理よろしくまおと
    }
    
    private func handleLogin() {
        // ログイン画面に移動するのを後々書く
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(.plain)
            .padding(12)
            .background(Color(UIColor.systemFill))
            .cornerRadius(8)
            .frame(maxWidth: .infinity)
    }
}

struct CustomSecureField: View {
    let placeholder: String
    @Binding var text: String
    @State private var isSecured: Bool = true
    
    var body: some View {
        HStack{
            if isSecured {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(.plain)
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle(.plain)
            }
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: isSecured ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
                    .frame(width: 20, height: 20)
            }
        }
        .padding(12)
        .background(Color(UIColor.systemFill))
        .cornerRadius(8)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RegisterView()
}
