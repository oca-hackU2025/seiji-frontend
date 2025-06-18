//
//  customTextField.swift
//  myApp
//
//  Created by 安野巧真 on 2025/06/17.
//

import SwiftUI

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
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .padding(.trailing, 32) // アイコン分の余白

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: isSecured ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
        }
        .padding(12)
        .background(Color(UIColor.systemFill))
        .cornerRadius(8)
    }
}
