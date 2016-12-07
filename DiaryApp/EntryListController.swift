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

