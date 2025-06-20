//
//  CardView.swift
//  myApp
//
//  Created by tkt on 2025/06/19.
//

import SwiftUI

struct CardView: View {
    
    @State private var offset: CGSize = .zero
    @State private var currentDisplayIndex: Int = 0
    let user: User
    let adjustIndex: (Bool) -> Void
    
    // タップ時の画面種類
    private let displayTypes: [DisplayType] = [.poster, .manifesto, .career, .sns]
    
    private func getImageName(for type: DisplayType) -> String {
        switch type {
            case .poster:
                return "poster_\(user.id)"
            case .manifesto:
                return "manifesto_\(user.id)"
            case .career:
                return "career_\(user.id)"
            case .sns:
                return "sns_\(user.id)"
        }
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            // poster
            posterLayer
            
            // Infomation
            informationLayer
        }
        .background(Color(UIColor.systemGray6))
        .overlay(
            // Like and Nope
            LikeAndNope,
            alignment: .bottom
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .offset(offset)
        .gesture(gesture)
        .scaleEffect(scale)
        .rotationEffect(.degrees(angle))
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NOPEACTION"), object: nil)) { data in
            print("ListViewModelからの通知を受信しました。 \(data)")
            guard
                let info = data.userInfo,
                let id = info["id"] as? String
            else { return }
            
            if id == user.id {
                removeCard(isLiked: false)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("LIKEACTION"), object: nil)) { data in
            print("ListViewModelからの通知を受信しました。 \(data)")
            guard
                let info = data.userInfo,
                let id = info["id"] as? String
            else { return }
            
            if id == user.id {
                removeCard(isLiked: true)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("REDOACTION"), object: nil)) { data in
            print("ListViewModelからの通知を受信しました。 \(data)")
            guard
                let info = data.userInfo,
                let id = info["id"] as? String
            else { return }
            
            if id == user.id {
                resetaCard()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"),
                                                        object: nil)) { data in
            receiveHandler(data: data)
        }
    }
}

#Preview {
    ListView()
}

// MARK: -UI
extension CardView {
    
    private var posterLayer: some View {
        ZStack {
            Image(getImageName(for: displayTypes[currentDisplayIndex]))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: 450)
                .padding(.top, 10)
                .clipped()
            
            HStack(spacing: 0) {
                // 左側タップエリア
                Color.clear
                    .onTapGesture {
                        withAnimation(.easeInOut(duration:  0.3)) {
                            currentDisplayIndex = max(0, currentDisplayIndex - 1)
                        }
                    }
                // 右側タップエリア
                Color.clear
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentDisplayIndex = min(displayTypes.count - 1, currentDisplayIndex + 1)
                        }
                    }
            }
        }
    }
    
    private var informationLayer: some View {
        VStack {
            // 名前と政党
            HStack {
                VStack(alignment: .leading) {
                    // ふりがな
                    Text(user.furigana)
                        .font(.callout)
                    // 名前と年齢
                    HStack(alignment: .lastTextBaseline) {
                        // 名前
                        Text(user.name)
                            .font(.system(size: 32, weight: .heavy))
                        // 年齢
                        Text("\(user.age)")
                            .font(.title2)
                    }
                }
                
                // 左右に分ける
                Spacer()
                
                // 政党と立場
                VStack(alignment: .trailing) {
                    // 立場
                    Text(user.mbti.rawValue)
                        .font(.headline.bold())
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    // 政党
                    Text(user.party)
                        .font(.title2.bold())
                }
            }
            // スローガン
            Text("\"" + user.slogan + "\"")
                .font(.title2.bold())
                .italic()
                .lineLimit(2)  // 最大2行まで許可
                .minimumScaleFactor(0.8)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding()
        .background(Color(UIColor.systemGray6))
    }
    
    
    private var LikeAndNope: some View {
        HStack {
            // Like
            Text("LIKE")
                .likeNopeText(isLike: true)
                .opacity(opacity)
            
            Spacer()
            
            //Nope
            Text("NOPE")
                .likeNopeText(isLike: false)
                .opacity(-opacity)
        }
        .frame(maxHeight: .infinity)
        .padding(.bottom, 60)
    }
}

// MARK: -Action
extension CardView {
    
    private var screenWidth: CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as?
                UIWindowScene else { return 0.0 }
        return window.screen.bounds.width
    }
    
    private var scale: CGFloat {
        return max(1.0 - (abs(offset.width) / screenWidth), 0.75)
    }
    
    private var angle: Double {
        return (offset.width / screenWidth) * 10.0
    }
    
    private var opacity: Double {
        return (offset.width / screenWidth) * 4.0
    }
    
    private func removeCard(isLiked: Bool, height: CGFloat = 0.0) {
        withAnimation(.smooth) {
            offset = CGSize(width: isLiked ? screenWidth  * 1.5: -screenWidth * 1.5, height: height)
        }
        
        adjustIndex(false)
    }
    
    private func resetaCard(fromButton: Bool = false) {
        withAnimation(.smooth) {
            offset = .zero
        }
        
        if fromButton {
            adjustIndex(true)
        }
    }
    
    private var gesture: some Gesture {
        DragGesture()
            .onChanged{ value in
                let width = value.translation.width
                let height = value.translation.height
                
                let limitedHeight = height > 0 ? min(height, 100) : max(height, -100)
                
                offset = CGSize(width: width, height: limitedHeight)
            }
            .onEnded { value in
                let width = value.translation.width
                let height = value.translation.height
                
                guard let window = UIApplication.shared.connectedScenes.first as?
                        UIWindowScene else { return }
                let screenWidth = window.screen.bounds.width
                
                if (abs(width) > (screenWidth / 4)) {
                    removeCard(isLiked: width > 0, height: height)
                } else {
                    resetaCard()
                }
            }
    }
    private func receiveHandler(data: NotificationCenter.Publisher.Output) {
        guard
            let info = data.userInfo,
            let id = info["id"] as? String,
            let action = info["action"] as? Action
        else { return }
        
        if id == user.id {
            switch action {
            case .nope:
                removeCard(isLiked: false)
            case .redo:
                resetaCard(fromButton: true)
            case .like:
                removeCard(isLiked: true)
            }
        }
    }
    
    enum DisplayType: CaseIterable {
        case poster
        case manifesto
        case career
        case sns
    }
}
