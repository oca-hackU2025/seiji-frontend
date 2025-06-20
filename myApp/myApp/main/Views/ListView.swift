//
//  ListView.swift
//  myApp
//
//  Created by tkt on 2025/06/19.
//

import SwiftUI

struct ListView: View {
    
    private let viewModel = ListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            // Cards
            cards
            
            // Actions
            actions
        }
        .background(.white, in: RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal, 6)
    }
}

#Preview {
    ListView()
}

extension ListView {
    
    private var cards: some View {
        ZStack {
            ForEach(viewModel.users.reversed()) { user in
                CardView(user: user) { isRedo in
                    viewModel.adjustIndex(isRedo: isRedo)
                }
            }
        }
    }
    
    private var actions: some View {
        HStack(spacing: 68) {
            ForEach(Action.allCases, id: \.self) { type in
                type.createActionButton(viewModel: viewModel)
            }
        }
        .foregroundStyle(.white)
        .frame(height: 80)
    }
}

