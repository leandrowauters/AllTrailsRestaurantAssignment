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

struct NetworkClient {
    
    
    static let baseURL = "https://maps.googleapis.com/maps/api/place/"
    static let output = "json"
    
    struct ConstantParameters {
       
        static func urlQueryItems() -> [URLQueryItem] {
            let radius = "1500"
            let type = "restaurant"
            let keyQuery = URLQueryItem(name: "key", value: NetworkKeys.googleAPIKey)
            let radiusQuery = URLQueryItem(name: "radius", value: radius)
            let typeQuery = URLQueryItem(name: "type", value: type)
            return [keyQuery,radiusQuery,typeQuery]
        }
    }
    
    enum SearchType {
        case Nearby
        case Text
        
        func baseURL() -> String {
            let baseURL = NetworkClient.baseURL
            let output = NetworkClient.output
            var searchType = String()
            switch self {
            case .Nearby:
                searchType = "nearbysearch/"
            case .Text:
                searchType = "textsearch/"
            }
            return baseURL + searchType + output
        }
        
    }
    

    
    static func endpoint(searchType: SearchType, location: String, textSearch: String?) -> URL? {
        
        let baseURL = searchType.baseURL()
        
       var urlComponents = URLComponents(string: baseURL)
        
        // MARK: PARAMETERS
        
        // Constant parameters:
        var parameters = ConstantParameters.urlQueryItems()
        let locationQuery = URLQueryItem(name: "location", value: location)
        
        
        parameters.append(locationQuery)
        
        
        // Case based parameters:
        
        switch searchType {
        case .Nearby:
            urlComponents?.queryItems = parameters
        case .Text:
            guard let textSearch = textSearch else {
                return nil
            }
            let textQuery = URLQueryItem(name: "query", value: textSearch)
            parameters.append(textQuery)
            urlComponents?.queryItems = parameters
        }
        
        return urlComponents?.url
    }
    

    
    static func fetchPlacesData(location: String, seachType: SearchType, textSearch: String?, completion: @escaping(Result<[ResultWrapper], NetworkError>) -> Void) {
        
        
//        var components = URLComponents()
//        components.queryItems  = [
//            URLQueryItem(name: "key", value: NetworkKeys.googleAPIKey),
//            URLQueryItem(name: "location", value: coordinatesQuery),
//            URLQueryItem(name: "radius", value:
//                            EndpointComponents.QueryValue.radius),
//            URLQueryItem(name: "type", value: EndpointComponents.QueryValue.type)
//        ]
        
        guard let url = NetworkClient.endpoint(searchType: seachType, location: location, textSearch: textSearch) else {
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
