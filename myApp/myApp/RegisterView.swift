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
        }
        .textFieldStyle(.roundedBorder)
    }
}

#Preview {
    RegisterView()
}
