//
//  EditModalViewController.swift
//  SimpleKeyboardApp
//
//  Created by Peter on 25/10/22.
//

import Foundation

import UIKit



protocol EditModalViewControllerDelegate: AnyObject {
    
        func didEditPhrase(phrase: Phrase, indexPath: IndexPath)
        func didDeletePhrase(phrase: Phrase)
    
}

class EditModalViewController: UIViewController {

    @IBOutlet var emojiTextField: UITextField!
    @IBOutlet var textField: UITextField!
    
    var phrase:Phrase?
    var indexPath:IndexPath?
    weak var delegate: EditModalViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = phrase?.texts
        emojiTextField.text = phrase?.emoji
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        delegate?.didEditPhrase(phrase: Phrase(id: phrase!.id, texts: textField.text!, emoji: emojiTextField.text!), indexPath: indexPath!)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        delegate?.didDeletePhrase(phrase: phrase!)
    }
    
}
