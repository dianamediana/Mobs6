//
//  MovieInfo.swift
//  Mediana
//
//  Created by dianaMediana on 20.12.2020.
//

import Foundation
import UIKit

class MoviesInfo: UIViewController {
        @IBOutlet weak var posterView: UIImageView!
        @IBOutlet weak var titleView: UILabel!
        @IBOutlet weak var yearView: UILabel!
        @IBOutlet weak var typeView: UILabel!
        @IBOutlet weak var productionView: UILabel!
        @IBOutlet weak var genreView: UILabel!
        @IBOutlet weak var countryView: UILabel!
        @IBOutlet weak var languageView: UILabel!
        @IBOutlet weak var directorView: UILabel!
        @IBOutlet weak var imdbRatingView: UILabel!
        @IBOutlet weak var imdbVotesView: UILabel!
        @IBOutlet weak var writerView: UILabel!
        @IBOutlet weak var actorsView: UILabel!
        @IBOutlet weak var releasedView: UILabel!
        @IBOutlet weak var runtimeView: UILabel!
        @IBOutlet weak var awardsView: UILabel!
        @IBOutlet weak var ratedView: UILabel!
        @IBOutlet weak var plotView: UILabel!
        
        var movieInformation: MovieInfo?
        var movieGeneral: Movie?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            fillAllInfoLabels()
        }
        
        func fillAllInfoLabels() {
            posterView.image = movieGeneral?.poster
            titleView.text = "Title: " + (movieGeneral?.title)!
            yearView.text = "Year: " + (movieGeneral?.year)!
            typeView.text = "Type: " + (movieGeneral?.type)!
            productionView.text = "Production: " + movieInformation!.Production
            genreView.text = "Genre: " + movieInformation!.Genre
            countryView.text = "Country: " + movieInformation!.Country
            languageView.text = "Language: " + movieInformation!.Language
            directorView.text = "Director: " + movieInformation!.Director
            imdbRatingView.text = "Rating(IMDB): " + movieInformation!.imdbRating
            imdbVotesView.text = "Votes(IMDB): " + movieInformation!.imdbVotes
            writerView.text = "Writer: " + movieInformation!.Writer
            actorsView.text = "Actors: " + movieInformation!.Actors
            releasedView.text = "Released: " + movieInformation!.Released
            runtimeView.text = "Runtime: " + movieInformation!.Runtime
            awardsView.text = "Awards: " + movieInformation!.Awards
            ratedView.text = "Rated: " + movieInformation!.Rated
            plotView.text = "Plot: " + movieInformation!.Plot
        }
}
