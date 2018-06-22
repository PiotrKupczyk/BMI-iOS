//
//  ViewController.swift
//  BMI
//
//  Created by Piotr Kupczyk on 21.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
    
    let segmentedControl = UISegmentedControl(items: ["Metric", "Imperial"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        self.view.backgroundColor = .white
        setUpNavigationBar()
        switchToMetrics()
    }
    
    lazy var imperialViewController: ImperialViewController = {
        var viewController = ImperialViewController()
        self.addChildViewControllerAsContainer(childViewController: viewController)
        
        return viewController
    }()
    
    lazy var metricsViewController: MetricsViewController = {
        var viewController = MetricsViewController()
        self.addChildViewControllerAsContainer(childViewController: viewController)
        
        return viewController
    }()
    
    private func setUpNavigationBar() {
        segmentedControl.selectedSegmentIndex = 0
        
        //style segmented control
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = .black
        
        //setup functionality
        segmentedControl.addTarget(self, action: #selector(switchUnits(_:)), for: .valueChanged)
        
        //Setup navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: segmentedControl)
        navigationItem.title = "BMI"
        navigationController?.hidesBarsOnSwipe = true
    }
    
    @objc func switchUnits(_ sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
        case 0:
            switchToMetrics()
        default:
            switchToImperial()
        }
    }

    
    private func addChildViewControllerAsContainer(childViewController: UIViewController) {
        addChildViewController(childViewController)
        let childView = childViewController.view
        
        view.addSubview(childView!)
        childView?.frame = view.bounds
        childViewController.didMove(toParentViewController: self)
        
    }
    
    private func switchToMetrics() {
        imperialViewController.view.isHidden = true
        metricsViewController.view.isHidden = false
    }

    private func switchToImperial() {
        imperialViewController.view.isHidden = false
        metricsViewController.view.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

