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

    lazy var section: Section = CheckInSection(checkIns: checkIns)

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
