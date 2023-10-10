//
//  MovieNetworkLayer.swift
//  Yassir Task
//
//  Created by Magdy Khaled on 09/10/2023.
//

import Foundation
class MovieNetworkLayer: MovieDataProtocol {
    
    static let shared = MovieNetworkLayer()
    private init() {}
    
    private let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    private let baseURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = helperMethods.jsonDecoder
    
    func getMovies(completion: @escaping (Result<MovieResponseModel, HandelMovieError>) -> ()) {
        guard let url = URL(string: "\(baseURL)/discover/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.callingApi(url: url, completion: completion)
    }
    
    func getMovie(id: Int, completion: @escaping (Result<Movie, HandelMovieError>) -> ()) {
        guard let url = URL(string: "\(baseURL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.callingApi(url: url, params: [
            "append_to_response": "videos,credits"
        ], completion: completion)
    }
    
    
    private func callingApi<D: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<D, HandelMovieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionHandlerInMainThread(with: .failure(.apiError), completion: completion)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandlerInMainThread(with: .failure(.invalidResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandlerInMainThread(with: .failure(.noData), completion: completion)
                return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandlerInMainThread(with: .success(decodedResponse), completion: completion)
            } catch {
                self.executeCompletionHandlerInMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandlerInMainThread<D: Decodable>(with result: Result<D, HandelMovieError>, completion: @escaping (Result<D, HandelMovieError>) -> ()) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
