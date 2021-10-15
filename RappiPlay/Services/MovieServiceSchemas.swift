//
//  MovieServiceSchema.swift
//  RappiPlay
//
//  Created by Jorge Miranda on 15/10/21.
//

import Foundation

class MovieServiceSchemas {
    
    // MARK: - GetByCategoryResponse
    
    // MARK: - TvCategoryResponse
    struct TvCategoryResponse: Codable {
        let page: Int?
        let results: [TvResult]?
        let totalPages, totalResults: Int?
        enum CodingKeys: String, CodingKey {
            case page, results
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
    }

    // MARK: - Result
    struct TvResult: Codable {
        let backdropPath, firstAirDate: String?
        let genreIDS: [Int]?
        let id: Int
        let name: String?
        let originCountry: [String]?
        let originalLanguage, originalName, overview: String?
        let popularity: Double?
        let posterPath: String?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case firstAirDate = "first_air_date"
            case genreIDS = "genre_ids"
            case id, name
            case originCountry = "origin_country"
            case originalLanguage = "original_language"
            case originalName = "original_name"
            case overview, popularity
            case posterPath = "poster_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
    
    // MARK: - MovieCategoryResponse
    struct MovieCategoryResponse: Codable {
        let page: Int?
        let results: [MovieResult]?
        let totalPages, totalResults: Int?
        enum CodingKeys: String, CodingKey {
            case page, results
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
    }

    // MARK: - Result
    struct MovieResult: Codable {
        let adult: Bool?
        let backdropPath: String?
        let genreIDS: [Int]?
        let id: Int?
        let originalLanguage, originalTitle, overview: String?
        let popularity: Double?
        let posterPath, releaseDate, title: String?
        let video: Bool?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }



    // MARK: - TvDetails
    struct TvDetails: Codable {
        let backdropPath: String?
        let createdBy: [CreatedBy]?
        let episodeRunTime: [Int]?
        let firstAirDate: String?
        let genres: [Genre]
        let homepage: String?
        let id: Int?
        let inProduction: Bool?
        let languages: [String]?
        let lastAirDate: String?
        let lastEpisodeToAir: TEpisodeToAir?
        let name: String?
        let nextEpisodeToAir: TEpisodeToAir?
        let networks: [Network]?
        let numberOfEpisodes, numberOfSeasons: Int?
        let originCountry: [String]?
        let originalLanguage, originalName, overview: String?
        let popularity: Double?
        let posterPath: String?
        let productionCompanies: [Network]?
        let productionCountries: [ProductionCountry]?
        let seasons: [Season]?
        let spokenLanguages: [SpokenLanguage]?
        let status, tagline, type: String?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case createdBy = "created_by"
            case episodeRunTime = "episode_run_time"
            case firstAirDate = "first_air_date"
            case genres, homepage, id
            case inProduction = "in_production"
            case languages
            case lastAirDate = "last_air_date"
            case lastEpisodeToAir = "last_episode_to_air"
            case name
            case nextEpisodeToAir = "next_episode_to_air"
            case networks
            case numberOfEpisodes = "number_of_episodes"
            case numberOfSeasons = "number_of_seasons"
            case originCountry = "origin_country"
            case originalLanguage = "original_language"
            case originalName = "original_name"
            case overview, popularity
            case posterPath = "poster_path"
            case productionCompanies = "production_companies"
            case productionCountries = "production_countries"
            case seasons
            case spokenLanguages = "spoken_languages"
            case status, tagline, type
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }

    // MARK: - CreatedBy
    struct CreatedBy: Codable {
        let id: Int?
        let creditID, name: String?
        let gender: Int?
        let profilePath: String?

        enum CodingKeys: String, CodingKey {
            case id
            case creditID = "credit_id"
            case name, gender
            case profilePath = "profile_path"
        }
    }

    // MARK: - Genre
    struct Genre: Codable {
        let id: Int?
        let name: String?
    }

    // MARK: - TEpisodeToAir
    struct TEpisodeToAir: Codable {
        let airDate: String?
        let episodeNumber, id: Int?
        let name, overview, productionCode: String?
        let seasonNumber: Int?
        let stillPath: String?
        let voteAverage, voteCount: Double?

        enum CodingKeys: String, CodingKey {
            case airDate = "air_date"
            case episodeNumber = "episode_number"
            case id, name, overview
            case productionCode = "production_code"
            case seasonNumber = "season_number"
            case stillPath = "still_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }

    // MARK: - Network
    struct Network: Codable {
        let name: String?
        let id: Int?
        let logoPath, originCountry: String?

        enum CodingKeys: String, CodingKey {
            case name, id
            case logoPath = "logo_path"
            case originCountry = "origin_country"
        }
    }

    // MARK: - ProductionCountry
    struct ProductionCountry: Codable {
        let iso3166_1, name: String?

        enum CodingKeys: String, CodingKey {
            case iso3166_1 = "iso_3166_1"
            case name
        }
    }

    // MARK: - Season
    struct Season: Codable {
        let airDate: String?
        let episodeCount, id: Int?
        let name, overview: String?
        let posterPath: String?
        let seasonNumber: Int?

        enum CodingKeys: String, CodingKey {
            case airDate = "air_date"
            case episodeCount = "episode_count"
            case id, name, overview
            case posterPath = "poster_path"
            case seasonNumber = "season_number"
        }
    }

    // MARK: - SpokenLanguage
    struct SpokenLanguage: Codable {
        let englishName, iso639_1, name: String?

        enum CodingKeys: String, CodingKey {
            case englishName = "english_name"
            case iso639_1 = "iso_639_1"
            case name
        }
    }
    
    // MARK: - MovieDetails
    struct MovieDetails: Codable {
        let adult: Bool?
        let backdropPath: String?
        let BelongsToCollection: BelongsToCollection?
        let budget: Int?
        let genres: [Genre]?
        let homepage: String?
        let id: Int?
        let imdbID, originalLanguage, originalTitle, overview: String?
        let popularity: Double?
        let posterPath: String?
        let productionCompanies: [ProductionCompany]?
        let productionCountries: [ProductionCountry]?
        let releaseDate: String?
        let revenue, runtime: Int?
        let spokenLanguages: [SpokenLanguage]?
        let status, tagline, title: String?
        let video: Bool?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case BelongsToCollection = "belongs_to_collection"
            case budget, genres, homepage, id
            case imdbID = "imdb_id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case productionCompanies = "production_companies"
            case productionCountries = "production_countries"
            case releaseDate = "release_date"
            case revenue, runtime
            case spokenLanguages = "spoken_languages"
            case status, tagline, title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }

    // MARK: - BelongsToCollection?
    struct BelongsToCollection: Codable {
        let id: Int?
        let name, posterPath, backdropPath: String?

        enum CodingKeys: String, CodingKey {
            case id, name
            case posterPath = "poster_path"
            case backdropPath = "backdrop_path"
        }
    }

    // MARK: - ProductionCompany
    struct ProductionCompany: Codable {
        let id: Int?
        let logoPath: String?
        let name, originCountry: String?

        enum CodingKeys: String, CodingKey {
            case id
            case logoPath = "logo_path"
            case name
            case originCountry = "origin_country"
        }
    }
    
    // MARK: - MovieCategoryResponse
    struct ContentDetailsImages: Codable {
        let backdrops: [Backdrop]?
        let id: Int?
        let logos, posters: [Backdrop]?
    }

    // MARK: - Backdrop
    struct Backdrop: Codable {
        let aspectRatio: Double?
        let height: Int?
        let iso639_1: String?
        let filePath: String?
        let voteAverage: Double?
        let voteCount, width: Int?

        enum CodingKeys: String, CodingKey {
            case aspectRatio = "aspect_ratio"
            case height
            case iso639_1 = "iso_639_1"
            case filePath = "file_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case width
        }
    }

}
