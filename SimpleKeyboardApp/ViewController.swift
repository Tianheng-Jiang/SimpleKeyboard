//
//  ViewController.swift
//  SimpleKeyboardApp
//
//  Created by Peter on 8/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var db:DBHelper = DBHelper()
    var phrases:[Phrase] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rows = getRows()

        // loop through rows
        phrases = db.read()
        if phrases.count == 0 {
            for row in rows {
                db.insert(texts: row[0], emoji: row[1])
                print("inserted \(row[0]) \(row[1])")
            }
        }
        phrases = db.read()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        phrases = db.read()
        tableView.reloadData()
    }
}


extension ViewController: UITableViewDelegate, EditModalViewControllerDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openEditModal(indexPath: indexPath)
    }

    func didEditPhrase(phrase: Phrase, indexPath: IndexPath) {
        db.updateByID(id: phrase.id, texts: phrase.texts, emoji: phrase.emoji)
        phrases[indexPath.row] = phrase
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

    func didDeletePhrase(phrase: Phrase) {
        db.deleteByID(id: phrase.id)
        phrases = db.read()
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

    func openEditModal(indexPath: IndexPath){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "EditModal") as! EditModalViewController
        vc.phrase = phrases[indexPath.row]
        vc.indexPath = indexPath
        vc.delegate = self
        present(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return phrases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Phrase: \(phrases[indexPath.row].texts) Icon: \(phrases[indexPath.row].emoji)"
        return cell
    }
}

