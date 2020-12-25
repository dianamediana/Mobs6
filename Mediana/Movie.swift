//
//  Movie.swift
//  Mediana
//
//  Created by dianaMediana on 20.12.2020.
//

import Foundation
import UIKit

class Movie {
    var poster: UIImage?
    var year, title, type, imdbID, rated, released, runtime, genre, director, writer, actors, plot, language, country, awards, imdbRating, imdbVotes, production: String?
        
    init(title: String = "", year: String = "", type: String = "", poster: UIImage = UIImage(), imdbID: String = "") {
        self.title = title
        self.year = year
        self.type = type
        self.poster = poster
        self.imdbID = imdbID
    }
}
