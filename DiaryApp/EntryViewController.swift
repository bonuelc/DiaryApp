//
//  EntryViewController.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 12/6/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit

protocol EntryViewControllerDelegate {
    
    func entryViewController(entryViewController: EntryViewController, didFinishEditingEntryWithSave saveEntry: Bool)
}

class EntryViewController: UIViewController {
    
    // MARK: - UI
    
    lazy var textView: UITextView = {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        let textView = UITextView()
        
        textView.text = self.entry?.text ?? ""
        textView.textAlignment = NSTextAlignment.Natural
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    // MARK: Properties
    
    var entry: Entry?
    var delegate: EntryViewControllerDelegate?
    
    init(entry: Entry?) {
        
        self.entry = entry
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBarButtonItems()
    }
    
    // MARK: - Layout
    
    override func viewWillLayoutSubviews() {
        
        view.addSubview(textView)
        
        NSLayoutConstraint.activateConstraints([
            textView.leftAnchor.constraintEqualToAnchor(view.leftAnchor),
            textView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor),
            textView.rightAnchor.constraintEqualToAnchor(view.rightAnchor),
            textView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
        ])
    }
}

// MARK: - Helper Methods

extension EntryViewController {
    
    func setUpBarButtonItems() {
        
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelBarButtonItemTapped))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(saveBarButtonItemTapped))
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    @objc func cancelBarButtonItemTapped() {

        delegate?.entryViewController(self, didFinishEditingEntryWithSave: false)
    }
    
    @objc func saveBarButtonItemTapped() {
        
        delegate?.entryViewController(self, didFinishEditingEntryWithSave: true)
    }
}
