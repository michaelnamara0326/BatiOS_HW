//
//  NetworkManager.swift
//  BatiOS_HW
//
//  Created by Michael Namara on 2023/6/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodeFail
    case responseError
    case requestError
    case unknownError
}

class NetworkManager {
    static let shared = NetworkManager()
    private let decoder = JSONDecoder()
    private init(){}
    
    func requestData<T: Decodable>(url: String, completed: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else { return completed(.failure(.invalidURL)) }
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                return completed(.failure(.responseError))
            }
            
            guard error == nil else { return completed(.failure(.requestError))}
            
            if let data = data {
                do {
                    let data = try self.decoder.decode(T.self, from: data)
                    completed(.success(data))
                } catch {
                    completed(.failure(.decodeFail))
                }
            } else {
                completed(.failure(.unknownError))
            }
        }.resume()
    }
}
