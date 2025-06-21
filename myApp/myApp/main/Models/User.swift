//
//  User.swift
//  myApp
//
//  Created by tkt on 2025/06/19.
//

import Foundation
import SwiftUI
struct User: Identifiable, Codable {
    let id: String
    let name: String
    let furigana: String
    let age: Int
    var party: String
    var mbti: Mbti
    var poster: String
    var slogan: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case furigana = "name_furigana"
        case age
        case party = "party_name"
        case poster = "main_img"
        case slogan = "catch_phrase"
    }

    init(id: String, name: String, furigana: String, age: Int, party: String, mbti: Mbti, poster: String, slogan: String) {
        self.id = id
        self.name = name
        self.furigana = furigana
        self.age = age
        self.party = party
        self.mbti = mbti
        self.poster = poster
        self.slogan = slogan
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let intId = try container.decode(Int.self, forKey: .id)
        self.id = String(intId)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.furigana = try container.decode(String.self, forKey: .furigana)
        self.age = try container.decode(Int.self, forKey: .age)
        self.party = try container.decode(String.self, forKey: .party)
        self.poster = try container.decode(String.self, forKey: .poster)
        self.slogan = try container.decode(String.self, forKey: .slogan)
        
        self.mbti = .entp
    }
}
enum Mbti: String, CaseIterable, Codable {
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
    
    // MBTIタイプごとの背景色を返すプロパティ
    var backgroundColor: Color {
        switch self {
            // NT系（分析家）- 紫色
        case .intp, .intj, .entp, .entj:
            return .purple
            // SP系（探検家）- 黄色
        case .istp, .isfp, .estp, .esfp:
            return .yellow
            // SJ系（番人）- 水色
        case .istj, .isfj, .estj, .esfj:
            return .cyan
            // NF系（外交官）- 緑色
        case .infj, .infp, .enfj, .enfp:
            return .green
        }
    }
}

extension User {
    static let MOCK_USER1 = User(id: "1", name: "山元真咲", furigana: "やまもとまさき", age: 45, party: "未来改革党", mbti: .entp, poster: "poster_1", slogan: "子どもたちの未来を創る政治家")
    static let MOCK_USER2 = User(id: "2", name: "川村あやか", furigana: "かわむらあやか", age: 38, party: "市民の声ネット", mbti: .esfp, poster: "poster_2", slogan: "誰一人、取り残さない政治")
    static let MOCK_USER3 = User(id: "3", name: "大河原理人", furigana: "おおがわらまさと", age: 39, party: "インパクト維新党", mbti: .enfp, poster: "poster_3", slogan: "未来は俺に任せろ！")
    static let MOCK_USER4 = User(id: "4", name: "田中剛志", furigana: "たなかつよし", age: 78, party: "国民安全党", mbti: .istj, poster: "poster_4", slogan: "守るべきものがある")
}




