//
//  ViewController.swift
//  SwiftBegginer-Lesson-2
//
//  Created by Ivan Andreyshev on 14/09/2019.
//  Copyright © 2019 iandreyshev. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var notesTable: UITableView!
    @IBOutlet weak var emptyView: UILabel!
    
    private var _notes = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func ComposeButtonClick(_ sender: Any) {
        let note = "Note #\(_notes.count + 1)"
        _notes.append(note)
        
        notesTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (_notes.isEmpty) {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }

        return _notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell")! as UITableViewCell
        cell.textLabel?.text = _notes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            _notes.removeLast()
            tableView.reloadData()
        }
    }

}

