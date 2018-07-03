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

    open let items = ["Metric", "Imperial"]

    let segmentedControl = UISegmentedControl(items: ["Metric", "Imperial"])

    //TODO why can't I put items in to init

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return segmentedControl.numberOfSegments
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: items[indexPath.row], for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = view.bounds
        guard let navHeight = navigationController?.navigationBar.frame.height else {return .zero}
        return CGSize(width: bounds.width, height: bounds.height - navHeight)
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
        collectionView?.register(MetricalCollectionViewCell.self, forCellWithReuseIdentifier: items[0])
        collectionView?.register(ImperialCollectionViewCell.self, forCellWithReuseIdentifier: items[1])
        collectionView?.isPagingEnabled = true
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let numberOfCurrentScreen = targetContentOffset.pointee.x / view.frame.width
        segmentedControl.selectedSegmentIndex = Int(numberOfCurrentScreen)
    }

    @objc func switchUnits(_ sender: UISegmentedControl!) {
        guard let collectionView = self.collectionView else {return}
        let cellSize = collectionView.bounds.width
        let contentOffset = CGFloat(sender.selectedSegmentIndex) * cellSize
        let frame: CGRect = CGRect(x: contentOffset, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)
        self.collectionView?.scrollRectToVisible(frame, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

