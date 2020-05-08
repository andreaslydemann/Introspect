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

protocol ReflectionListViewControllerDelegate: AnyObject {
    func didSelectNewReflection(_ userId: String, viewController: ReflectionListViewController)
    func didSelectPastReflection(_ userId: String, viewController: ReflectionListViewController)
}

struct Reflection {
    let date: Date
}

final class ReflectionListViewController: UIViewController {
    weak var delegate: ReflectionListViewControllerDelegate?
    private var reflections: [Reflection] = []

    convenience init(reflections: [Reflection]) {
        self.init()
        self.reflections = reflections
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CarouselFlowLayout())
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delaysContentTouches = false

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(NewReflectionCell.self)
        collectionView.register(PastReflectionCell.self)

        return collectionView
    }()

    lazy var section: Section = ReflectionSection(reflections: reflections)

    func setupViews() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
}

extension ReflectionListViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return section.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return section.configureCell(collectionView: collectionView, indexPath: indexPath)
    }
}

extension ReflectionListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }

        if cell.isKind(of: NewReflectionCell.self) {
            delegate?.didSelectNewReflection("my user id", viewController: self)
        } else if cell.isKind(of: PastReflectionCell.self) {
            delegate?.didSelectPastReflection("my user id", viewController: self)
        } else {
            fatalError("Unknown cell type received")
        }
    }
}
