//
//  ReflectionSection.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 19/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit

protocol Section {
    var numberOfItems: Int { get }
    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
}

struct ReflectionSection: Section {
    var numberOfItems: Int {
        if reflections.isEmpty { return 1 }
        return reflections.count + (reflections.first!.date.compare(.isToday) ? 0 : 1)
    }

    private let reflections: [Reflection]

    init(reflections: [Reflection]) {
        self.reflections = reflections
    }

    func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        if reflections.isEmpty {
            return collectionView.dequeueReusable(withCell: NewReflectionCell.self, for: indexPath)
        }

        if let firstReflection = reflections.first, !firstReflection.date.compare(.isToday), indexPath.row == 0 {
            return collectionView.dequeueReusable(withCell: NewReflectionCell.self, for: indexPath)
        } else {
            return collectionView.dequeueReusable(withCell: PastReflectionCell.self, for: indexPath)
        }
    }
}
