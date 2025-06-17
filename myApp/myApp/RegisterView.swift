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
    var body: some View {
        VStack {
            TextField(
                "メールアドレス",
                text: $email
            )
            .textFieldStyle(.plain)
            .padding(6)
            .background(Color(UIColor.systemFill), in: .rect(cornerRadius: 6))
            TextField(
                "パスワード",
                text: $password
            )
            .textFieldStyle(.plain)
            .padding(6)
            .background(Color(UIColor.systemFill), in: .rect(cornerRadius: 6))
            TextField(
                "パスワード確認",
                text: $passwordConfirm
            )
            .textFieldStyle(.plain)
            .padding(6)
            .background(Color(UIColor.systemFill), in: .rect(cornerRadius: 6))
            Button("新規登録") {
                
            }.disabled(email.isEmpty || password.isEmpty)
        }
        .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    RegisterView()
}
