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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBarButtonItems()
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
        
        entryVC.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        entryVC.navigationItem.leftItemsSupplementBackButton = true
        
        self.navigationController?.pushViewController(entryVC, animated: true)
    }
}

// MARK: - Helper Methods

extension EntryListController {
    
    func setUpBarButtonItems() {
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(presentEntryViewController))
        navigationItem.rightBarButtonItem = addButton
    }
}