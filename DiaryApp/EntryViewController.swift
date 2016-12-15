//
//  EntryViewController.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 12/6/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

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
    
    lazy var geolocateButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "icn_geolocate.png"), forState: .Normal)
        
        button.addTarget(self, action: #selector(toggleLocation), forControlEvents: .TouchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        
        activityIndicator.hidden = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    // MARK: Properties
    
    var entry: Entry?
    var delegate: EntryViewControllerDelegate?
    var location: Location? {
        didSet {
            geolocateButton.backgroundColor = location == nil ? .clearColor() : .blueColor()
        }
    }
    
    let locationManager: LocationManager
    let managedObjectContext: NSManagedObjectContext
    
    init(entry: Entry?, locationManager: LocationManager = LocationManager(), managedObjectContext: NSManagedObjectContext) {
        
        self.entry = entry
        self.locationManager = locationManager
        self.managedObjectContext = managedObjectContext
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBarButtonItems()
        
        // needs to be in viewDidLoad to trigger didSet
        location = entry?.location
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        delegate?.entryViewController(self, didFinishEditingEntryWithSave: true)
    }
    
    // MARK: - Layout
    
    override func viewWillLayoutSubviews() {
        
        view.addSubview(geolocateButton)
        view.addSubview(activityIndicator)
        view.addSubview(label)
        view.addSubview(textView)
        
        NSLayoutConstraint.activateConstraints([
            geolocateButton.widthAnchor.constraintEqualToConstant(40.0),
            geolocateButton.heightAnchor.constraintEqualToConstant(40.0),
            geolocateButton.leftAnchor.constraintEqualToAnchor(view.leftAnchor),
            geolocateButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
            
            activityIndicator.leftAnchor.constraintEqualToAnchor(geolocateButton.leftAnchor),
            activityIndicator.topAnchor.constraintEqualToAnchor(geolocateButton.topAnchor),
            activityIndicator.rightAnchor.constraintEqualToAnchor(geolocateButton.rightAnchor),
            activityIndicator.bottomAnchor.constraintEqualToAnchor(geolocateButton.bottomAnchor),
            
            label.leftAnchor.constraintEqualToAnchor(geolocateButton.rightAnchor),
            label.topAnchor.constraintEqualToAnchor(geolocateButton.topAnchor),
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
    
    @objc func toggleLocation() {
        
        if location != nil {
            
            location = nil
            
        } else {
            
            activityIndicator.startAnimating()
            
            locationManager.onLocationFix = { placemark, error in
                
                self.activityIndicator.stopAnimating()
                
                guard let location = Location.location(withPlacemark: placemark, inManagedObjectContext: self.managedObjectContext) else {
                    return
                }
                
                self.location = location
            }
        }
    }
}
