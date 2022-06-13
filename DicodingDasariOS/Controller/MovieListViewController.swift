//
//  ViewController.swift
//  DicodingDasariOS
//
//  Created by Arga Hutama on 05/06/22.
//

import UIKit

class MovieListViewController: UIViewController {
    let alert = UIAlertController(
        title: nil,
        message: "Please wait...",
        preferredStyle: .alert
    )
    let dataManager = DataManager()
    var movies = [Movie]()
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadingIndicator =
            UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        dataManager.delegate = self
        dataManager.fetchMovie()
        
        movieTableView.register(
            UINib(nibName: "MovieTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MovieCell"
        )
    }
    
}

extension MovieListViewController: MovieManagerDelegate {
    func didUpdateMovies(_ movieManager: DataManager, movies: [Movie]) {
        alert.dismiss(animated: false, completion: nil)
        DispatchQueue.main.async {
            self.movies = movies
            self.movieTableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        alert.dismiss(animated: false, completion: nil)
        print("error \(error)")
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return movies.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieCell",
            for: indexPath
        ) as? MovieTableViewCell {
            let movie = movies[indexPath.row]
            cell.titleLabel.text = movie.title
            cell.overviewLabel.text = movie.overview
            cell.overviewLabel.numberOfLines = 3
            cell.overviewLabel.adjustsFontSizeToFitWidth = false
            cell.overviewLabel.lineBreakMode = .byTruncatingTail
            cell.movieImageView.loadImageFromServer(
                urlString: movie.getBackdropUrl()
            )
            cell.movieImageView.makeRounded()
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        performSegue(
            withIdentifier: "MovieDetail",
            sender: movies[indexPath.row]
        )
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        if segue.identifier == "MovieDetail" {
            if let detaiViewController = segue.destination as? MovieDetailViewController {
                detaiViewController.movie = sender as? Movie
            }
        }
    }
}
