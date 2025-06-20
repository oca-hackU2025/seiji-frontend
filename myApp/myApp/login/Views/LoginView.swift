//
//  LoginView.swift
//  myApp
//
//  Created by 安野巧真 on 2025/06/17.
//

import SwiftUI

struct LoginView: View {
    @Binding var selection: Int
    @StateObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                CustomTextField(
                    placeholder: "メールアドレス",
                    text: $loginViewModel.email
                )
                CustomSecureField(
                    placeholder: "パスワード",
                    text: $loginViewModel.password                )
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button("ログイン") {
                    loginViewModel.login()
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(!loginViewModel.isSubmit || loginViewModel.isLoading ? Color.gray : Color.blue)
                .cornerRadius(8)
                .disabled(!loginViewModel.isSubmit || loginViewModel.isLoading)
                
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
}

#Preview {
    LoginView(selection: .constant(0))
}
