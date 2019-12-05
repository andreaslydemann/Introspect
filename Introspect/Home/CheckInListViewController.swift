//
//  ViewController.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 03/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit
import UI

/*public protocol CheckInListViewControllerDelegate: class {
    func didSelectCheckIn(_ userId: String, viewController: CheckInListViewController)
}*/

class CheckInListViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Best New Apps"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        view.backgroundColor = .green
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CheckInCollectionViewCell.self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusable(withCell: CheckInCollectionViewCell.self, for: indexPath)
    }
}

extension CheckInListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: view.frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

//extension CheckInListViewController: UICollectionViewDelegate { }
