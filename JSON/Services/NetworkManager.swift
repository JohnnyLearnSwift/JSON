//
//  NetworkManager.swift
//  JSON
//
//  Created by Eugenie Tyan on 31.08.2022.
//
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private let headers = [
        "X-RapidAPI-Key": "503ffa4ec3msh73b6086699c4e8ap13f413jsnfbbd6d3956ea",
        "X-RapidAPI-Host": "love-calculator.p.rapidapi.com"
    ]
    
    func fetchRequest(string: String, completion: @escaping (Result<LoveCalculation, Error>) -> Void) {
        guard let url = URL(string: string) else { return}
        var request = URLRequest(url: url,
                                       cachePolicy: .useProtocolCachePolicy,
                                       timeoutInterval: 10)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) {
            data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            guard let data = data else { return}
            
            do {
                let result = try JSONDecoder().decode(LoveCalculation.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private init() {}
}
