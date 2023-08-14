//
//  NetworkManager.swift
//  rick-and-morty
//
//  Created by Carlos Morgado on 14/8/23.
//

import Foundation

protocol NetworkManager {
    
    func request<T: Decodable>(url: URL, httpMethod: NetworkHttpMethod, successCompletion: @escaping (T) -> Void, errorCompletion: @escaping (Error) -> Void)
    
}

struct DefaultNetworkManager {
    
    private let session: URLSession
        
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
}

extension DefaultNetworkManager: NetworkManager {
    
    func request<T: Decodable>(url: URL, httpMethod: NetworkHttpMethod, successCompletion: @escaping (T) -> Void, errorCompletion: @escaping (Error) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorCompletion(NetworkError.requestError(error))
                }
            } else {
                guard let httpResponse = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        errorCompletion(NetworkError.invalidResponse)
                    }
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    DispatchQueue.main.async {
                        errorCompletion(NetworkError.invalidStatusCode(httpResponse.statusCode))
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        errorCompletion(NetworkError.invalidData)
                    }
                    return
                }
                
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        successCompletion(decodedObject)
                    }
                } catch {
                    debugPrint("Could not decode received data from URL \(url) to object \(T.self)")
                    debugPrint("Decoder error: \(error)")
                    DispatchQueue.main.async {
                        errorCompletion(NetworkError.invalidData)
                    }
                }
            }
        }.resume()
    }
    
}

