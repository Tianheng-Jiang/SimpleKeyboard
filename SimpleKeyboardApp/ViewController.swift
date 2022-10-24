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
    }
}


extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        db.deleteByID(id: phrases[indexPath.row].id)
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

