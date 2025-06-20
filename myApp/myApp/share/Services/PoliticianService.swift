//
//  GeneratePolitician.swift
//  myApp
//
//  Created by kmjak on 2025/06/20.
//

import Foundation

struct PoliticianService {
    static func generatePolitician( completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/private/politicians/generate") else {
            completion(.failure(PoliticianServiceError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        var accessToken: String = KeychainHelper.load() ?? ""
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(PoliticianServiceError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    // JSONとしてデコードせずに文字列として表示
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("受け取ったデータ: \(jsonString)")
                    }
                }
                completion(.success(()))
            } else {
                completion(.failure(PoliticianServiceError.serverError(statusCode: httpResponse.statusCode)))
            }
        }.resume()    }
}

enum PoliticianServiceError: Error {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
}
