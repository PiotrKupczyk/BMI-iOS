//
//  ViewController.swift
//  BMI
//
//  Created by Piotr Kupczyk on 21.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let segmentedControl = UISegmentedControl(items: ["Metric", "Imperial"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.backgroundColor = .white
        setUpNavigationBar()
//        switchToMetrics()
        collectionView?.register(MetricalCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentedControl.numberOfSegments
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
//        cell.backgroundColor = .purple
        segmentedControl.selectedSegmentIndex = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = view.bounds
        let navheight = navigationController?.navigationBar.frame.height
        return CGSize(width: bounds.width, height: bounds.height - navheight!)
    }
    
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
//        navigationController?.hidesBarsOnSwipe = true
    }
    
    @objc func switchUnits(_ sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
        case 0:
//            switchToMetrics()
            print("0")
        default:
//            switchToImperial()
            print("0")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

