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

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if checkIns.isEmpty {
            return collectionView.dequeueReusable(withCell: CreateCheckInCell.self, for: indexPath)
        }

        if let firstCheckIn = checkIns.first, !firstCheckIn.date.compare(.isToday), indexPath.row == 0 {
            return collectionView.dequeueReusable(withCell: CreateCheckInCell.self, for: indexPath)
        } else {
            return collectionView.dequeueReusable(withCell: PastCheckInCell.self, for: indexPath)
        }
    }
}
