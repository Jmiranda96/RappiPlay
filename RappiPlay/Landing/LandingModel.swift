//
//  LandingModel.swift
//  RappiPlay
//
//  Created by Jorge Miranda on 12/10/21.
//

import Foundation

protocol LandingDelegate {
    func refreshUpcoming()
    func refreshPopular()
    func refreshTopRated()
}

class LandingModel {
    
    var movieServices = MovieService()
    var delegate: LandingDelegate!
    var upcomingList = [Any]() {
        didSet {
            self.delegate.refreshUpcoming()
        }
    }
    var upcomingPageCount = 1
    var popularList = [Any]() {
        didSet {
            self.delegate.refreshPopular()
        }
    }
    var popularPageCount = 1
    var topRatedList = [Any]() {
        didSet {
            self.delegate.refreshTopRated()
        }
    }
    var topRatedPageCount = 1
    
    
    func resetContent() {
        topRatedPageCount = 1
        popularPageCount = 1
        upcomingPageCount = 1
        upcomingList.removeAll()
        popularList.removeAll()
        topRatedList.removeAll()
    }
    
    func updateUpcoming<ResultSchema>(list: [ResultSchema]?, error: Any?) {
        // check for error in response
        guard error == nil else {
            return
        }
            
        guard let movieResults = list else {
            return
        }
        self.upcomingPageCount+=1
        self.upcomingList.append(contentsOf: movieResults)
    }
    
    func updatePopular<ResultSchema>(list: [ResultSchema]?, error: Any?) {
        // check for error in response
        guard error == nil else {
            return
        }
            
        guard let movieResults = list else {
            return
        }
        self.popularPageCount+=1
        self.popularList.append(contentsOf: movieResults)
    }
    
    func updateTopRated<ResultSchema>(list: [ResultSchema]?, error: Any?) {
        // check for error in response
        guard error == nil else {
            return
        }
            
        guard let movieResults = list else {
            return
        }
        self.topRatedPageCount+=1
        self.topRatedList.append(contentsOf: movieResults)
    }
    
    func getUpcoming(for contentType: MovieService.MediaType) {
        switch contentType {
        case .Movie:
            movieServices.fetchMovieByCategory(by: MovieService.CategoryType.Upcoming, page: upcomingPageCount, closure: updateUpcoming)
        case .Tv:
            movieServices.fetchTVByCategory(by: MovieService.CategoryType.AiringToday, page: upcomingPageCount, closure: updateUpcoming)
        }
    }
    
    func getPopular(for contentType: MovieService.MediaType) {
        switch contentType {
        case .Movie:
            movieServices.fetchMovieByCategory(by: MovieService.CategoryType.Popular, page: upcomingPageCount, closure: updatePopular)
        case .Tv:
            movieServices.fetchTVByCategory(by: MovieService.CategoryType.Popular, page: upcomingPageCount, closure: updatePopular)
        }
    }
    
    func getTopRated(for contentType: MovieService.MediaType) {
        switch contentType {
        case .Movie:
            movieServices.fetchMovieByCategory(by: MovieService.CategoryType.TopRated, page: upcomingPageCount, closure: updateTopRated)
        case .Tv:
            movieServices.fetchTVByCategory(by: MovieService.CategoryType.TopRated, page: upcomingPageCount, closure: updateTopRated)
        }
    }
}
