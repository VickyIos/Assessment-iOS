//
//  WeatherListViewController.swift
//  assessment-ios
//
//  Created by Vignesh on 22/01/21.
//  Copyright © 2021 Vignesh. All rights reserved.
//

import UIKit

class WeatherListViewController: UIViewController {

    // MARK: - Properties

    // MARK: - Lifecycle
    
    // Custom initializers go here

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - User Interactions
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    
    // MARK: - UI and Constraints methods

    fileprivate func setupViews() {
        view.backgroundColor = .white

        setupConstraints()
    }

    fileprivate func setupConstraints() {
        
    }
}


