//
//  AuthService.swift
//  myApp
//
//  Created by 安野巧真 on 2025/06/18.
//

import Foundation

struct AuthService {
    static func sendTokenToBackend(_ idToken: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/auth/login") else {
            completion(.failure(AuthServiceError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["idToken": idToken]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(AuthServiceError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(AuthServiceError.serverError(statusCode: httpResponse.statusCode)))
            }
        }.resume()
    }
}

enum AuthServiceError: Error {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
}
