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
