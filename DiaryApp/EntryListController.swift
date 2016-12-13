//
//  EntryListController.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 12/6/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit
import CoreData

class EntryListController: UIViewController {
    
    // MARK: - UI
    
    lazy var tableView: UITableView = {
        return UITableView()
    }()
    
    // MARK: Properties
    
    var managedObjectContext: NSManagedObjectContext?    
    lazy var dataSource: EntryDataSource = {
        return EntryDataSource(tableView: self.tableView, fetchRequest: Entry.allEntriesRequest, managedObjectContext: self.managedObjectContext!)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBarButtonItems()
        
        tableView.dataSource = dataSource
    }
    
    // MARK: - Layout
    
    override func viewWillLayoutSubviews() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints([
            tableView.leftAnchor.constraintEqualToAnchor(view.leftAnchor),
            tableView.topAnchor.constraintEqualToAnchor(topLayoutGuide.topAnchor),
            tableView.rightAnchor.constraintEqualToAnchor(view.rightAnchor),
            tableView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
        ])
    }
}

// MARK: - Navigation

extension EntryListController {
    
    @objc func presentEntryViewController() {
        
        let entryVC = EntryViewController()
        entryVC.entry = Entry.entry(inManagedObjectContext: managedObjectContext!)
        entryVC.delegate = self
        
        entryVC.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        entryVC.navigationItem.leftItemsSupplementBackButton = true
        
        self.navigationController?.pushViewController(entryVC, animated: true)
    }
}

// MARK: - Helper Methods

extension EntryListController {
    
    func setUpBarButtonItems() {
        
        let editButton = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(toggleEditing(_:)))
        navigationItem.leftBarButtonItem = editButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(presentEntryViewController))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func toggleEditing(sender: UIBarButtonItem) {
        
        if !tableView.editing {
            tableView.editing = true
            sender.title = "Done"
            sender.style = .Done
        } else {
            tableView.editing = false
            sender.title = "Edit"
            sender.style = .Plain
        }
    }
}

// MARK: EntryViewControllerDelegate

extension EntryListController: EntryViewControllerDelegate {
    
    func entryViewController(entryViewController: EntryViewController, didFinishEditingEntryWithSave saveEntry: Bool) {
        
        if saveEntry {
            
            guard let entry = entryViewController.entry else { return }
            
            entry.text = entryViewController.textView.text
            
            if let _ = entry.dateCreated {
                // old entry
                entry.dateModified = NSDate()
            } else {
                // new entry
                entry.dateCreated = NSDate()
            }
            
        }
    }
}