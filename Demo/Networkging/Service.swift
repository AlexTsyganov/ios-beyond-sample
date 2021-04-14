//
//  Service.swift
//  Demo
//
//  Created by The App Experts on 14/04/2021.
//

import Foundation

//https://beyond-sample.yams.brandwidth.com/list

enum NetworkError: Error {
    case malFormedUrl(message: String)
    case dataError(message: String)
    case errorWith(code: String)
    case parsingFailed(message: String)
}
typealias CompletionHandler<T:Codable> = ((Result<T, NetworkError>) -> Void)

protocol Servicable {
    func getData<T:Codable>(client:NetworkClient, type:T.Type, completion:@escaping CompletionHandler<T>)
}

class Service: Servicable {
    func getData<T>(client: NetworkClient, type: T.Type, completion: @escaping CompletionHandler<T>) where T : Decodable, T : Encodable {
        
        guard  let urlComponents = URLComponents(string: client.baseUrl + client.path) else {
            completion(.failure(.malFormedUrl(message:"URL not correct")))
            return
        }
        
        guard let url = urlComponents.url else  {
            completion(.failure(.malFormedUrl(message:"URL not correct")))
            return
        }
        
        let urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            
            if let _response = response as?  HTTPURLResponse, _response.statusCode != 200  {
                completion(.failure(.errorWith(code:"Failed to Fetch Data with code \(_response.statusCode)")))
                return
            }
            guard let data = data else {
                completion(.failure(.dataError(message:"Data is not found")))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(.parsingFailed(message:"Data Parsing Failed")))
            }
        }
        
        dataTask.resume()
        
    }
}
