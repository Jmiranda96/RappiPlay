//
//  MovieService.swift
//  RappiPlay
//
//  Created by Jorge Miranda on 12/10/21.
//

import Foundation

import Foundation
import Alamofire
class MovieService {
    
    
    let apiKey: String
    let apiURL: String
    
    var sessionManager: Session?
    var offset = 0
    var limit = 20
    
    enum RequestError: Error {
        case invalidStatus
        case errorInRequest
        var errorDescription: String? {
            switch self {
            case .invalidStatus:
                return "invalidStatus"
            case .errorInRequest:
                return "errorInRequest"
            }
        }
    }
    
    enum MediaType: Error {
        case Tv
        case Movie
        var mediaParam: String {
            switch self {
            case .Movie:
                return "movie"
            case .Tv:
                return "tv"
            }
        }
    }
    
    enum CategoryType: Error {
        case Popular
        case TopRated
        case Upcoming
        case AiringToday
        var categoryParam: String {
            switch self {
            case .Popular:
                return "popular"
            case .TopRated:
                return "top_rated"
            case .Upcoming:
                return "upcoming"
            case .AiringToday:
                return "airing_today"
            }
        }
    }
    
    init(testing: Bool = false) {
        // get url direction from info.plist
        guard let serverUrl = Bundle.main.infoDictionary?["api-url"] as? String  else {
            fatalError("api direction not found")
        }
        self.apiURL = serverUrl
        
        // get api key from info.plist
        guard let serverApiKey = Bundle.main.infoDictionary?["api-key"] as? String else {
            fatalError("api key not found")
        }
        self.apiKey = serverApiKey
        
        // Init of session manager (mock purposes)
        
        guard testing else {
            let sessionMockConfig = URLSessionConfiguration.default
            sessionMockConfig.timeoutIntervalForResource = 10
            sessionMockConfig.timeoutIntervalForRequest = 5
            let newSession = Session(configuration: sessionMockConfig)
            self.sessionManager = newSession
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
        
        let responseCacher = ResponseCacher(behavior: .modify { _, response in
            let userInfo = ["date": Date(), "isCache": true] as [String : Any]
          return CachedURLResponse(
            response: response.response,
            data: response.data,
            userInfo: userInfo,
            storagePolicy: .allowed)
        })
        
        self.sessionManager = Session(configuration: sessionConfig, cachedResponseHandler: responseCacher)
        
    }
    
    /// function to fetch list of records by categories
    func fetchByCategory(for mediaType: MediaType, by category: CategoryType, page: Int ,closure: @escaping  (GetByCategoryResponse?, RequestError?) -> Void) {
        
        guard let session = sessionManager else {
            print("NIL SESSION MANAGER")
            return
        }
        
        session.request("\(self.apiURL)\(mediaType.mediaParam)/\(category.categoryParam)?api_key=\(self.apiKey)&page=\(page)").responseDecodable(of: GetByCategoryResponse.self) { (response) in
            
            guard response.error == nil else {
                closure( nil, RequestError.errorInRequest)
                return
            }
            
            guard response.response?.statusCode == 200 else {
                closure( nil, RequestError.invalidStatus)
                return
            }
            
            guard let mediaByCategory = response.value else { return }
            closure(mediaByCategory, nil)
        }
    }
    
    //MARK: - data models
    
    struct GetByCategoryResponse: Codable, Equatable {
        var dates: DateRange?
        var page: Int?
        var results: [MovieResult]?
    }
    
    struct DateRange: Codable, Equatable {
        var maximum: String?
        var minimum: String?
    }
    
    struct MovieResult: Codable, Equatable {
        var poster_path: String?
        var adult: Bool?
        var overview: String?
        var release_date: String?
        var genre_ids: [Int]?
        var id: Int?
        var original_title: String?
        var original_language: String?
        var title: String?
        var backdrop_path: String?
        var popularity: Double?
        var vote_count: Int?
        var video: Bool?
        var vote_average: Double?
    }

}
