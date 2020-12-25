//
//  MovieCell.swift
//  Mediana
//
//  Created by dianaMediana on 20.12.2020.
//

import Foundation
import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var yearView: UILabel!
    @IBOutlet weak var typeView: UILabel!
        
    func insertNewMovie(movie: Movie) {
        posterView.image = movie.poster
        titleView.text = movie.title
        yearView.text = movie.year
        typeView.text = movie.type
    }
        
    func insertNewMovieWithoutPoster(movie: Movie) {
        titleView.text = movie.title
        yearView.text = movie.year
        typeView.text = movie.type
    }
}
