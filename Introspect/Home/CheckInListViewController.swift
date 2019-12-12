//
//  ViewController.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 03/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UI
import UIKit

protocol CheckInListViewControllerDelegate: AnyObject {
    func didSelectCheckIn(_ userId: String, viewController: CheckInListViewController)
}

final class CheckInListViewController: UIViewController {
    weak var delegate: CheckInListViewControllerDelegate?

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

        collectionView.register(CheckInCollectionViewCell.self)

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
        return section.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return section.configureCell(collectionView: collectionView, indexPath: indexPath)
    }

    func collectionView(_: UICollectionView, didSelectItemAt _: IndexPath) {
        delegate?.didSelectCheckIn("my user id", viewController: self)
    }
}

extension CheckInListViewController: UICollectionViewDelegate {}

struct CheckInSection {
    let numberOfItems = 5

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CheckInCollectionViewCell.self), for: indexPath)
        return cell
    }
}
