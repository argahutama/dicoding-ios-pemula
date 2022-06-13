//
//  Movie.swift
//  DicodingDasariOS
//
//  Created by Arga Hutama on 05/06/22.
//

import Foundation

struct Movie: Codable {
    let title: String
    let overview: String
    let release_date: String
    let poster_path: String
    let backdrop_path: String
    
    func getPosterUrl() -> String {
        return "\(DataManager.movieImageUrl)\(poster_path)"
    }
    
    func getBackdropUrl() -> String {
        return "\(DataManager.movieImageUrl)\(backdrop_path)"
    }
}
