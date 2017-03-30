//
//  AddEntryViewController.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 3/30/17.
//  Copyright © 2017 Christopher Bonuel. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController {
    lazy var addButton: UIButton = {
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitleColor(button.tintColor, forState: .Normal)
        
        button.setTitle("Add a new entry", forState: .Normal)
        
        button.addTarget(self, action: #selector(presentNewEntryViewController), forControlEvents: .TouchUpInside)
        
        return button
    }()
    
    var delegate: EntryListController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        navigationItem.leftItemsSupplementBackButton = true
        
        view.backgroundColor = .whiteColor()
    }
    
    override func viewWillLayoutSubviews() {
        
        view.addSubview(addButton)
        
        NSLayoutConstraint.activateConstraints([
            addButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            addButton.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
            ])
    }
    
    @objc func presentNewEntryViewController() {
        delegate?.presentNewEntryViewController()
    }
}
