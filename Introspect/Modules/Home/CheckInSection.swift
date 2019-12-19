//
//  CheckInSection.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 19/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UI
import UIKit

protocol Section {
    var numberOfItems: Int { get }
    func layoutSection() -> NSCollectionLayoutSection
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

struct CheckInSection: Section {
    var numberOfItems: Int {
        if checkIns.isEmpty { return 1 }
        return checkIns.count + (checkIns.first!.date.compare(.isToday) ? 0 : 1)
    }

    private let checkIns: [CheckIn]

    init(checkIns: [CheckIn]) {
        self.checkIns = checkIns
    }

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
        if checkIns.isEmpty {
            return collectionView.dequeueReusable(withCell: CreateCheckInCell.self, for: indexPath)
        }

        if let firstCheckIn = checkIns.first, !firstCheckIn.date.compare(.isToday), indexPath.row == 0 {
            return collectionView.dequeueReusable(withCell: CreateCheckInCell.self, for: indexPath)
        } else {
            return collectionView.dequeueReusable(withCell: CompletedCheckInCell.self, for: indexPath)
        }
    }
}
