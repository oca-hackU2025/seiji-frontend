//
//  User.swift
//  myApp
//
//  Created by tkt on 2025/06/19.
//

import Foundation

struct User: Identifiable {
    let id: String
    let name: String
    let furigana: String
    let age: Int
    var party: String
    var mbti: Mbti
    var poster: String
    var slogan: String
}

enum Mbti: String, CaseIterable {
    case istj = "ISTJ"
    case istp = "ISTP"
    case isfj = "ISFJ"
    case isfp = "ISFP"
    case intj = "INTJ"
    case intp = "INTP"
    case infj = "INFJ"
    case infp = "INFP"
    case estj = "ESTJ"
    case estp = "ESTP"
    case esfj = "ESFJ"
    case esfp = "ESFP"
    case entj = "ENTJ"
    case entp = "ENTP"
    case enfj = "ENFJ"
    case enfp = "ENFP"
}

extension User {
    static let MOCK_USER1 = User(id: "1", name: "山元真咲", furigana: "やまもとまさき", age: 45, party: "未来改革党", mbti: .entp, poster: "poster_1", slogan: "教育とテクノロジーで、子どもたちの未来を創る政治家")
    static let MOCK_USER2 = User(id: "2", name: "川村あやか", furigana: "かわむらあやか", age: 38, party: "市民の声ネットワーク", mbti: .esfp, poster: "poster_2", slogan: "誰一人、取り残さない政治")
    static let MOCK_USER3 = User(id: "3", name: "佐藤太郎", furigana: "さとうたろう", age: 52, party: "経済再生党", mbti: .isfj, poster: "poster_3", slogan: "地域経済の活性化で豊かな未来を")
    static let MOCK_USER4 = User(id: "4", name: "鈴木美咲", furigana: "すずきみさき", age: 29, party: "若者世代", mbti: .enfp, poster: "poster_4", slogan: "若い力で政治を変える！")
    static let MOCK_USER5 = User(id: "5", name: "高橋健一", furigana: "たかはしけんいち", age: 61, party: "伝統保守", mbti: .istj, poster: "poster_5", slogan: "経験と実績で安心できる街づくり")
    static let MOCK_USER6 = User(id: "6", name: "渡辺あゆみ", furigana: "わたなべあゆみ", age: 34, party: "環境第一", mbti: .istp, poster: "poster_6", slogan: "持続可能な社会を次世代に")
    static let MOCK_USER7 = User(id: "7", name: "小林正雄", furigana: "こばやしまさお", age: 47, party: "都市開発", mbti: .estp, poster: "poster_7", slogan: "インフラ整備で便利な街へ")
}




