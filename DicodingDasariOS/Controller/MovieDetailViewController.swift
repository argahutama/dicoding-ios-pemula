//
//  MovieDetailViewController.swift
//  DicodingDasariOS
//
//  Created by Arga Hutama on 05/06/22.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movie: Movie? = nil
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            movieImageView.loadImageFromServer(urlString: movie.getBackdropUrl())
            movieImageView.makeRoundedRectangle(radius: 16)
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
        }
    }
}
