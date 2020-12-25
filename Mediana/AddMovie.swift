//
//  AddMovie.swift
//  Mediana
//
//  Created by dianaMediana on 20.12.2020.
//

import Foundation
import UIKit

class AddMovie: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleInputedText: UITextField!
    @IBOutlet weak var yearInputedText: UITextField!
    @IBOutlet weak var typeInputedText: UITextField!
        
    @IBAction func addMovieButton(_ sender: Any) {
        performSegue(withIdentifier: "unwindToMoviesListVC", sender: self)
        view.endEditing(true)
    }
    @IBAction func doneEditingTitle(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func doneEditingYear(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func doneEditingType(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        titleInputedText.delegate = self
        yearInputedText.delegate = self
        typeInputedText.delegate = self
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
}
