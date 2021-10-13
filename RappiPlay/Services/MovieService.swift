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
    
    
    let regionCode: String
    let mlUrl: String
    
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
    
    init(session: Session? = Session(), testing: Bool = false) {
        // get url direction from info.plist
        guard let serverUrl = Bundle.main.infoDictionary?["ml-api-url"] as? String  else {
            fatalError("ML api direction not found")
        }
        self.mlUrl = serverUrl
        
        // get region from info.plist
        guard let serverRegion = Bundle.main.infoDictionary?["ml-api-region"] as? String else {
            fatalError("ML api region not found")
        }
        self.regionCode = serverRegion
        
        // Init of session manager (mock purposes)
        
        guard testing else {
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForResource = 10
            sessionConfig.timeoutIntervalForRequest = 5
            let newSession = Session(configuration: sessionConfig)
            self.sessionManager = newSession
            return
        }
        
        self.sessionManager = session
        
    }
    
    /// function to fetch list of categories available in region
    func fetchCategories(closure: @escaping  ([MLCategoryDetails]?, RequestError?) -> Void) {
        
        guard let session = sessionManager else {
            print("NIL SESSION MANAGER")
            return
        }
        
        session.request("\(self.mlUrl)sites/\(self.regionCode)/categories").responseDecodable(of: [MLCategoryDetails].self) { (response) in
            
            guard response.response?.statusCode == 200 else {
                closure( nil, RequestError.invalidStatus)
                return
            }
            
            guard response.error == nil else {
                closure( nil, RequestError.errorInRequest)
                return
            }
            
            guard let categories = response.value else { return }
            closure(categories, nil)
        }
    }
    
    /// fetch detail of category by his id
    func fetchDetailCategory(_ id: String, closure: @escaping  (MLCategoryDetails?, RequestError?) -> Void) {
        
        guard let session = sessionManager else {
            print("NIL SESSION MANAGER")
            return
        }
        
        session.request("\(self.mlUrl)categories/\(id)").responseDecodable(of: MLCategoryDetails.self) { (response) in

            guard response.response?.statusCode == 200 else {
                closure( nil, RequestError.invalidStatus)
                return
            }
            
            guard response.error == nil else {
                closure( nil, RequestError.errorInRequest)
                return
            }
            
            guard let details = response.value else { return }
            closure(details, nil)
        }
    }
    
    
    /// fetch list of items fetched by category and/or id
    func fetchItems(byCategory cat: String = "", bySearch q: String = "", isNewPage: Bool = false, closure: @escaping  (MLISearchResponse?, RequestError?) -> Void ) {
        guard let session = sessionManager else {
            print("NIL SESSION MANAGER")
            return
        }
        
        let queryCat = cat.isEmpty ? "" : "category=\(cat)"
        
        let queryQ = q.isEmpty ? "" : "q=\(q)"
        
        if !isNewPage {
            limit = 20
            offset = 0
        }
    
        let stringLimit = String(limit)
        let stringOffset = String(offset)
        
        self.offset+=limit
        
        session.request("\(self.mlUrl)sites/\(self.regionCode)/search?\(queryCat)&\(queryQ)&offset=\(stringOffset)&limit=\(stringLimit)").responseDecodable(of: MLISearchResponse.self) { (response) in
            
            guard response.response?.statusCode == 200 else {
                closure( nil, RequestError.invalidStatus)
                return
            }
            
            guard response.error == nil else {
                closure( nil, RequestError.errorInRequest)
                return
            }
            
            guard let results = response.value else { return }
            closure(results, nil)
        }
        
    }
    
    
    func fetchItemDetails(id: String, closure: @escaping  (MLItemResponse?, RequestError?) -> Void){
        guard let session = sessionManager else {
            print("NIL SESSION MANAGER")
            return
        }
        session.request("\(self.mlUrl)items/\(id)").responseDecodable(of: MLItemResponse.self) { (response) in
            
            guard response.response?.statusCode == 200 else {
                closure( nil, RequestError.invalidStatus)
                return
            }
            
            guard response.error == nil else {
                closure( nil, RequestError.errorInRequest)
                return
            }
            
            guard let results = response.value else { return }
            closure(results, nil)
        }
    }
    
    //MARK: - data models
    
    struct MLCategoryDetails: Codable, Equatable {
        var id: String? = ""
        var name: String? = ""
        var picture: String? = ""
    }
    
    struct MLISearchResponse: Codable, Equatable {
        var site_id: String? = ""
        var query: String? = ""
        var results: [MLSearchResult]?
    }
    
    struct MLSearchResult: Codable, Equatable {
        var id: String?
        var title: String?
        var price: Int?
        var category_id: String?
        var thumbnail: String?
    }
    
    struct MLItemResponse: Codable, Equatable {
        var title: String? = ""
        var price: Int? = 0
        var condition: String? = ""
        var permalink: String? = ""
        var sold_quantity: Int? = 0
        var pictures: [MLPicture]? = [MLPicture()]
        var attributes: [MLAttributes]? = [MLAttributes()]
    }
    
    struct MLPicture: Codable, Equatable {
        var secure_url: String? = ""
    }
    
    struct MLAttributes: Codable, Equatable {
        var name: String? = ""
        var value_name: String? = ""
    }
}
