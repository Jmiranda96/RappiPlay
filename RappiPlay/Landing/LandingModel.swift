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
    var upcomingList = [MovieService.MovieResult]() {
        didSet {
            self.delegate.refreshUpcoming()
        }
    }
    var upcomingPageCount = 1
    var popularList = [MovieService.MovieResult]() {
        didSet {
            self.delegate.refreshPopular()
        }
    }
    var popularPageCount = 1
    var topRatedList = [MovieService.MovieResult]() {
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
    
    func getUpcoming(for contentType: MovieService.MediaType) {
        // fetch categories from mlServices
        movieServices.fetchByCategory(for: contentType, by: contentType == .Movie ? MovieService.CategoryType.Upcoming : MovieService.CategoryType.AiringToday, page: upcomingPageCount, closure:
            { (list, error)  in
            
            // check for error in response
            guard error == nil else {
                return
            }
                
            guard let movieResults = list?.results else {
                return
            }
            self.upcomingPageCount+=1
            self.upcomingList.append(contentsOf: movieResults)
        })
    }
    
    func getPopular(for contentType: MovieService.MediaType) {
        // fetch categories from mlServices
        movieServices.fetchByCategory(for: contentType, by: MovieService.CategoryType.Popular, page: popularPageCount, closure:
            { (list, error)  in
            
            // check for error in response
            guard error == nil else {
                return
            }
                
            guard let movieResults = list?.results else {
                return
            }
            self.popularPageCount+=1
            self.popularList.append(contentsOf: movieResults)
        })
    }
    
    func getTopRated(for contentType: MovieService.MediaType) {
        // fetch categories from mlServices
        movieServices.fetchByCategory(for: contentType, by: MovieService.CategoryType.TopRated, page: topRatedPageCount, closure:
            { (list, error)  in
            
            // check for error in response
            guard error == nil else {
                return
            }
                
            guard let movieResults = list?.results else {
                return
            }
            self.topRatedPageCount+=1
            self.topRatedList.append(contentsOf: movieResults)
        })
    }
}
