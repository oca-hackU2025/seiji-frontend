//
//  RegisterView.swift
//  myApp
//
//  Created by kmjak on 2025/06/15.
//

import SwiftUI

struct RegisterView: View {
    @Binding var selection: Int
    @StateObject private var registerViewModel = RegisterViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                CustomTextField(
                    placeholder: "メールアドレス",
                    text: $registerViewModel.email
                )
                .textInputAutocapitalization(.never)
                CustomSecureField(
                    placeholder: "パスワード",
                    text: $registerViewModel.password
                )
                .textInputAutocapitalization(.never)
                CustomSecureField(
                    placeholder: "パスワード確認",
                    text: $registerViewModel.passwordConfirm
                )
                .textInputAutocapitalization(.never)
                
                if registerViewModel.message != "" {
                    Text(registerViewModel.message)
                        .foregroundStyle(registerViewModel.isSuccess ? .green : .red)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button("新規登録") {
                    registerViewModel.register()
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(!registerViewModel.isSubmit || registerViewModel.isLoading ? Color.gray : Color.blue)
                .cornerRadius(8)
                .disabled(!registerViewModel.isSubmit || registerViewModel.isLoading)
                
                Button("すでにアカウントをお持ちの方") {
                    selection = 0
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
    RegisterView(selection: .constant(1))
}
