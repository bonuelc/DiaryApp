//
//  EntryViewController.swift
//  DiaryApp
//
//  Created by Christopher Bonuel on 12/6/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
        
    // MARK: Properties
    
    var entry: Entry?
    
    init(entry: Entry?) {
        
        self.entry = entry
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

