//
//  DataManager.swift
//  DicodingDasariOS
//
//  Created by Arga Hutama on 05/06/22.
//

import Foundation

protocol MovieManagerDelegate {
    func didUpdateMovies(_ movieManager: DataManager, movies: [Movie])
    func didFailWithError(error: Error)
}


class DataManager {
    let apiKey = "7521ad57a6b5f8bbe36f9551abbb5955"
    let movieUrl = "https://api.themoviedb.org/3/movie/popular"
    static let movieImageUrl = "https://image.tmdb.org/t/p/w500"
    
    var delegate: MovieManagerDelegate?
    
    func fetchMovie() {
        performRequest()
    }
    
    func performRequest() {
        let url = "\(movieUrl)?api_key=\(apiKey)"
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let movies = self.parseJSON(safeData) {
                        self.delegate?.didUpdateMovies(self, movies: movies)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [Movie]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieResponse.self, from: data)
            return decodedData.results
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
