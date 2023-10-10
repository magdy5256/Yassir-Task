//
//  MovieDataProtocol.swift
//  Yassir Task
//
//  Created by Magdy Khaled on 09/10/2023.
//

import Foundation


protocol MovieDataProtocol {
    
    func getMovies(completion: @escaping (Result<MovieResponseModel, HandelMovieError>) -> ())
    func getMovie(id: Int, completion: @escaping (Result<Movie, HandelMovieError>) -> ())
}

enum HandelMovieError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var errorDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }
    
    var errorInfo: [String : Any] {
        [NSLocalizedDescriptionKey: errorDescription]
    }
    
}

class helperMethods {
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
}
