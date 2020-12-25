//
//  ViewController.swift
//  Mediana
//
//  Created by dianaMediana on 20.12.2020.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var nothingFoundView: UIView!
    var moviesFromTheFile: [Movie] = []
    var searchedMoviesFromTheFile: [Movie] = []
    var addedMovie: Movie?
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchedMoviesFromTheFile = []
            if searchText == "" {
                searchedMoviesFromTheFile = moviesFromTheFile
            } else {
                nothingFoundView.isHidden = true
                for name in moviesFromTheFile {
                    if name.title!.lowercased().contains(searchText.lowercased()) {
                        searchedMoviesFromTheFile.append(name)
                    }
                }
                if searchedMoviesFromTheFile.count == 0 {
                    nothingFoundView.isHidden = false
                }
            }
            self.tableView.reloadData()
            if searchedMoviesFromTheFile.count == 0 {
                nothingFoundView.isHidden = false
            }
            else {
                nothingFoundView.isHidden = true
            }
        }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            nothingFoundView.isHidden = true
            self.fillArrayWithParsedDataFromFile(fileName: "MoviesList")
            searchedMoviesFromTheFile = moviesFromTheFile
            tableView.keyboardDismissMode = .onDrag
        }
        
    private func readLocalFile(forName name: String) -> Data? {
            do {
                if let bundlePath = Bundle.main.path(forResource: name, ofType: "txt"),
                   let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    return jsonData
                }
            } catch {
                print(error)
            }
            return nil
        }
        
    private func parse(jsonData: Data) -> MoviesCodable? {
            do {
                let decodedData = try JSONDecoder().decode(MoviesCodable.self, from: jsonData)
                return decodedData
            } catch {
                print(error)
            }
            return nil
        }
        
    private func parseForDetailedStruct(jsonData: Data) -> MovieInfo? {
            do {
                let decodedData = try JSONDecoder().decode(MovieInfo.self, from: jsonData)
                return decodedData
            } catch {
                print(error)
            }
            return nil
        }
        
    private func transferParsedMovieInfoToAnotherView(filename: String) -> MovieInfo? {
            if let localData = self.readLocalFile(forName: filename) {
                let decodedData = self.parseForDetailedStruct(jsonData: localData)
                return decodedData
            }
            return nil
        }
        
    private func fillArrayWithParsedDataFromFile(fileName: String?){
            if let localData = self.readLocalFile(forName: fileName!) {
                let decodedData = self.parse(jsonData: localData)
                decodedData?.Search.forEach {
                    let pic = UIImage(named: "\($0.Poster)")
                    moviesFromTheFile.append(Movie(title: $0.Title, year: $0.Year, type: $0.type, poster: $0.Poster.count == 0 ? UIImage() : pic!, imdbID: $0.imdbID))
                }
            }
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.identifier == "movieInfoNext" else { return }
            guard let destination = segue.destination as? MoviesInfo else { return }
            let id: Movie = searchedMoviesFromTheFile[tableView.indexPathForSelectedRow!.row]
            if id.imdbID == "" || id.imdbID == nil {
                destination.movieInformation = MovieInfo(Rated: "", Released: "", Runtime: "", Genre: "", Director: "", Writer: "", Actors: "", Plot: "", Language: "", Country: "", Awards: "", imdbRating: "", imdbVotes: "", Production: "")
            }
            else {
                if let dataToTransfer = self.transferParsedMovieInfoToAnotherView(filename: "\(id.imdbID!)") {
                    destination.movieInformation = dataToTransfer
                } else {
                    destination.movieInformation = MovieInfo(Rated: "", Released: "", Runtime: "", Genre: "", Director: "", Writer: "", Actors: "", Plot: "", Language: "", Country: "", Awards: "", imdbRating: "", imdbVotes: "", Production: "")
                }
            }
            destination.movieGeneral = id
        }
        
    @IBAction func unwindToMoviesListVC(_ unwindSegue: UIStoryboardSegue) {
            let sourceViewController = unwindSegue.source as? AddMovie
            addedMovie = Movie(title: sourceViewController?.titleInputedText.text ?? "", year: sourceViewController?.yearInputedText.text ?? "", type: sourceViewController?.typeInputedText.text ?? "")
            moviesFromTheFile.append(addedMovie!)
            checkForSearchBarActiveness()
            self.tableView.reloadData()
            }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if touches.first != nil {
                view.endEditing(true)
            }
            super.touchesBegan(touches, with: event)
        }
        
    func hideKeyboard(sender: UITapGestureRecognizer) {
            nothingFoundView.isHidden = true
            view.endEditing(true)
        }
        
    func checkForSearchBarActiveness() {
            if searchBarView.isFocused == false {
                searchedMoviesFromTheFile = moviesFromTheFile
                self.tableView.reloadData()
            }
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedMoviesFromTheFile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = searchedMoviesFromTheFile[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MovieCell
        if movie.poster!.isEqual(nil) {
            cell.insertNewMovieWithoutPoster(movie: movie)
        } else {
            cell.insertNewMovie(movie: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.tableView.beginUpdates()
            let i: String = searchedMoviesFromTheFile[indexPath.row].title!
            searchedMoviesFromTheFile.remove(at: indexPath.row)
            moviesFromTheFile.removeAll(where: { $0.title == i })
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
