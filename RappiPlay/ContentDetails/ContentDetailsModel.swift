//
//  ContentDetailsModel.swift
//  RappiPlay
//
//  Created by Jorge Miranda on 15/10/21.
//

import Foundation

protocol ContentDetailsDelegate {
    func setDetails()
    func setDetailImages()
    func errorInRequest()
}

class ContentDetailsModel {
 
    var delegate: ContentDetailsDelegate!
    var movieServices = MovieService()
    var detailInfo: Any!
    var detailsImages: MovieServiceSchemas.ContentDetailsImages!
    

    func updateDetails<ResultSchema>(list: ResultSchema?, error: Any?) {
        guard list != nil || error == nil else {
           self.delegate.errorInRequest()
           return
        }
        
        self.detailInfo = list
        
        self.delegate.setDetails()
        return
    }
    
    func updateImages(list: MovieServiceSchemas.ContentDetailsImages?, error: Any?) {
        guard list != nil || error == nil else {
           self.delegate.errorInRequest()
           return
        }
        
        self.detailsImages = list
        
        self.delegate.setDetailImages()
        return
    }
    
    func getDetails(id: Int, contentType: MovieService.MediaType ) {
        
        switch contentType {
        case .Movie:
            movieServices.fetchMovieDetails(for: contentType, id: id, closure: updateDetails)
        case .Tv:
            movieServices.fetchTvDetails(for: contentType, id: id, closure: updateDetails)
        }
    
        self.getDetailImges(id: id, contentType: contentType)
    }
    
    func getDetailImges(id: Int, contentType: MovieService.MediaType) {
        movieServices.fetchContentImages(for: contentType, id: id, closure: updateImages)
    }
}
