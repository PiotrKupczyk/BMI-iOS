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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = .white
        setUpNavigationBar()
        setupCollectionView()
    }
    
    let cellsIds = ["Metric", "Imperial"]
    let segmentedControl = UISegmentedControl(items: ["Metric", "Imperial"])
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentedControl.numberOfSegments
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsIds[indexPath.row], for: indexPath)
        
    
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
        segmentedControl.backgroundColor = .clear
        segmentedControl.tintColor = UIColor.AppColors.darkPrimaryColor
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: UIControlState.selected)
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: UIControlState.normal)
        segmentedControl.layer.borderColor = UIColor.black.cgColor
        
        //setup functionality
        segmentedControl.addTarget(self, action: #selector(switchUnits(_:)), for: .valueChanged)
        
        //Setup navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: segmentedControl)
        navigationItem.title = "BMI"
//        navigationController?.hidesBarsOnSwipe = true
        
        navigationController?.navigationBar.barTintColor = UIColor.AppColors.primaryColor
    }
    
    func setupCollectionView() {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 0
            flowLayout.scrollDirection = .horizontal
        }
        collectionView?.register(MetricalCollectionViewCell.self, forCellWithReuseIdentifier: cellsIds[0])
        collectionView?.register(ImperialCollectionViewCell.self, forCellWithReuseIdentifier: cellsIds[1])
        collectionView?.isPagingEnabled = true
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

