//
//  NetworkClient.swift
//  AllTrailsRestaurantAssignment
//
//  Created by Leandro Wauters on 8/27/21.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badStatusCode
    case apiError(Error)
    case jsonDecodingError(Error)
}

class NetworkClient {
    
   
    public func fetchPlacesData(completion: @escaping(Result<[ResultWrapper], NetworkError>) -> Void) {
        
        let endpointURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.apiError(error)))
            } else if
                let data = data,
                let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let result = try JSONDecoder().decode(Places.self, from: data)
                    completion(.success(result.results))
                } catch {
                    completion(.failure(.jsonDecodingError(error)))
                }
                
            }
        }
        task.resume()
    }
    
    
}
