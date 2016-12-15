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
    
    lazy var label: UILabel = {
        
        let label = UILabel()
        
        guard let entry = self.entry else { return label }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        
        if let dateModified = entry.dateModified {
            label.text = "Date modified: \(dateFormatter.stringFromDate(dateModified))"
        } else if let dateCreated = entry.dateCreated {
            label.text = "Date created: \(dateFormatter.stringFromDate(dateCreated))"
        }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.entryViewController(self, didFinishEditingEntryWithSave: true)
    }
    
    // MARK: - Layout
    
    override func viewWillLayoutSubviews() {
        
        view.addSubview(label)
        view.addSubview(textView)
        
        NSLayoutConstraint.activateConstraints([
            label.leftAnchor.constraintEqualToAnchor(view.leftAnchor),
            label.rightAnchor.constraintEqualToAnchor(view.rightAnchor),
            label.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
            
            textView.leftAnchor.constraintEqualToAnchor(view.leftAnchor),
            textView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor),
            textView.rightAnchor.constraintEqualToAnchor(view.rightAnchor),
            textView.bottomAnchor.constraintEqualToAnchor(label.topAnchor),
        ])
    }
}

// MARK: - Helper Methods

extension EntryViewController {
    
    func setUpBarButtonItems() {
        
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelBarButtonItemTapped))
//        navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(saveBarButtonItemTapped))
//        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    @objc func cancelBarButtonItemTapped() {

        delegate?.entryViewController(self, didFinishEditingEntryWithSave: false)
    }
    
    @objc func saveBarButtonItemTapped() {
        
        delegate?.entryViewController(self, didFinishEditingEntryWithSave: true)
    }
}
