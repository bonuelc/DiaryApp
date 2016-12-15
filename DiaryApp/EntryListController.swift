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
    
    let managedObjectContext: NSManagedObjectContext
    lazy var dataSource: EntryDataSource = {
        return EntryDataSource(tableView: self.tableView, fetchRequest: Entry.allEntriesRequest, managedObjectContext: self.managedObjectContext)
    }()
    
    init(managedObjectContext: NSManagedObjectContext) {
        
        self.managedObjectContext = managedObjectContext
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBarButtonItems()
        
        tableView.dataSource = dataSource
        tableView.delegate = self
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
    
    func presentEntryViewController(withEntry entry: Entry) {
        
        if let splitVC = splitViewController {
            
            let entryVC = EntryViewController(entry: entry, managedObjectContext: managedObjectContext)
            entryVC.delegate = self
            
            let entryNavController = UINavigationController(rootViewController: entryVC)
            
            splitVC.showDetailViewController(entryNavController, sender: nil)
        }
    }
    
    @objc func presentNewEntryViewController() {
        
        presentEntryViewController(withEntry: Entry.entry(inManagedObjectContext: managedObjectContext))
    }
}

// MARK: - UITableViewDelegate

extension EntryListController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        presentEntryViewController(withEntry: dataSource.entryAtIndexPath(indexPath))
    }
}

// MARK: - Helper Methods

extension EntryListController {
    
    func setUpBarButtonItems() {
        
        let editButton = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(toggleEditing(_:)))
        navigationItem.leftBarButtonItem = editButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(presentNewEntryViewController))
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
        
        guard let entry = entryViewController.entry else { return }
        
        if saveEntry {
            
            entry.text = entryViewController.textView.text
            entry.location = entryViewController.location
            
            if let _ = entry.dateCreated {
                // old entry
                entry.dateModified = NSDate()
            } else {
                // new entry
                entry.dateCreated = NSDate()
            }
            
        } else if entry.dateCreated == nil{
            // not an old entry
            dataSource.deleteEntry(entry)
        }
    }
}