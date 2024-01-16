//
//  Movie.swift
//  SwipeBoxTask
//
//  Created by Ali Sher on 14/01/2024.
//

import Foundation


struct MovieModel : Codable {
    
    let page : Int?
    let results : [Movie]?
    let total_pages : Int?
    let total_results : Int?
    let status_message : String?
    let status_code : Int?
    let success: Bool?
    
    
    enum CodingKeys: String, CodingKey {

        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
        case status_message = "status_message"
        case status_code = "status_code"
        case success = "success"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        results = try values.decodeIfPresent([Movie].self, forKey: .results)
        total_pages = try values.decodeIfPresent(Int.self, forKey: .total_pages)
        total_results = try values.decodeIfPresent(Int.self, forKey: .total_results)
        status_message = try values.decodeIfPresent(String.self, forKey: .status_message)
        status_code = try values.decodeIfPresent(Int.self, forKey: .status_code)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
}


struct Movie : Codable {
    
    var poster_path : String?
    var adult : Bool?
    var overview : String?
    var release_date : String?
    var genre_ids : [Int]?
    var id : Int?
    var original_title : String?
    var original_language : String?
    var title : String?
    var backdrop_path : String?
    var popularity : Double?
    var vote_count : Int?
    var video : Bool?
    var vote_average : Double?
    
    
    enum CodingKeys: String, CodingKey {

        case poster_path = "poster_path"
        case adult = "adult"
        case overview = "overview"
        case release_date = "release_date"
        case genre_ids = "genre_ids"
        case id = "id"
        case original_title = "original_title"
        case original_language = "original_language"
        case title = "title"
        case backdrop_path = "backdrop_path"
        case popularity = "popularity"
        case vote_count = "vote_count"
        case video = "video"
        case vote_average = "vote_average"
    }

    init() {
        
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
        genre_ids = try values.decodeIfPresent([Int].self, forKey: .genre_ids)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        original_title = try values.decodeIfPresent(String.self, forKey: .original_title)
        original_language = try values.decodeIfPresent(String.self, forKey: .original_language)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        backdrop_path = try values.decodeIfPresent(String.self, forKey: .backdrop_path)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        vote_count = try values.decodeIfPresent(Int.self, forKey: .vote_count)
        video = try values.decodeIfPresent(Bool.self, forKey: .video)
        vote_average = try values.decodeIfPresent(Double.self, forKey: .vote_average)
    }
}
