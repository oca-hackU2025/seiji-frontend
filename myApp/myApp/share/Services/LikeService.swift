import Foundation

struct LikeService {
    // いいねを送信する
    static func sendLike(seijikaId: Int, completion: @escaping (Result<LikeResponse, Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/private/likes") else {
            completion(.failure(LikeServiceError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Keychainからアクセストークンを取得
        let accessToken = KeychainHelper.load() ?? ""
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = ["seijika_id": seijikaId]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(LikeServiceError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let decoded = try JSONDecoder().decode(LikeResponse.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(LikeServiceError.serverError(statusCode: httpResponse.statusCode)))
            }
        }.resume()
    }
    
    // いいね一覧を取得する
    static func fetchLikedUsers(completion: @escaping (Result<[Int], Error>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/api/private/likes") else {
            completion(.failure(LikeServiceError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Keychainからアクセストークンを取得
        let accessToken = KeychainHelper.load() ?? ""
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(LikeServiceError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                do {
                    let decoded = try JSONDecoder().decode(LikedUsersResponse.self, from: data)
                    // APIから返されたIDのリストを抽出
                    let likedIds = decoded.liked_seijika.map { $0.id }
                    completion(.success(likedIds))
                } catch {
                    completion(.failure(error))
                }
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

struct LikeResponse: Codable {
    let message: String
}

struct LikedUsersResponse: Codable {
    let liked_seijika: [LikedUser]
}

struct LikedUser: Codable {
    let id: Int
}
