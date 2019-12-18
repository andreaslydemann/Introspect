//
//  ViewController.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 03/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import DateHelper
import UI
import UIKit

protocol CheckInListViewControllerDelegate: AnyObject {
    func didSelectCheckIn(_ userId: String, viewController: CheckInListViewController)
}

struct CheckIn {
    let date: Date
}

final class CheckInListViewController: UIViewController {
    weak var delegate: CheckInListViewControllerDelegate?
    private var checkIns: [CheckIn] = []
    
    convenience init(checkIns: [CheckIn]) {
        self.init()
        self.checkIns = checkIns
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        var section = self.section
        let layout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            section.layoutSection()
        }
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delaysContentTouches = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CreateCheckInCell.self)
        collectionView.register(CompletedCheckInCell.self)
        
        return collectionView
    }()
    
    let section = CheckInSection()
    
    func setupViews() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
}

extension CheckInListViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if checkIns.isEmpty { return 1 }
        return checkIns.count + (checkIns.first!.date.compare(.isToday) ? 0 : 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let firstCheckIn = checkIns.first, !firstCheckIn.date.compare(.isToday) && indexPath.row == 0 {
            return collectionView.dequeueReusable(withCell: CreateCheckInCell.self, for: indexPath)
        } else {
            return collectionView.dequeueReusable(withCell: CompletedCheckInCell.self, for: indexPath)
        }
    }
    
    func collectionView(_: UICollectionView, didSelectItemAt _: IndexPath) {
        delegate?.didSelectCheckIn("my user id", viewController: self)
    }
}

extension CheckInListViewController: UICollectionViewDelegate {}

struct CheckInSection {
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.94), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        return section
    }
    
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusable(withCell: CreateCheckInCell.self, for: indexPath)
    }
}
