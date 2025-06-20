//
//  LikeViewModel.swift
//  myApp
//
//  Created by kmjak on 2025/06/20.
//

import Foundation

struct LikeService {
    static func sendLike(politicianId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/likes") else {
            completion(.failure(LikeServiceError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["politicianId": politicianId]
        
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
                completion(.failure(LikeServiceError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(LikeServiceError.serverError(statusCode: httpResponse.statusCode)))
            }
        }.resume()
    }
}

enum LikeServiceError: Error {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
}
