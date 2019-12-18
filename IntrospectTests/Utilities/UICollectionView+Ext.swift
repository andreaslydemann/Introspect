//
//  UICollectionView+Ext.swift
//  IntrospectTests
//
//  Created by Andreas Lüdemann on 18/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit

extension UICollectionView {
    func cell(at row: Int) -> UICollectionViewCell? {
        return dataSource?.collectionView(self, cellForItemAt: IndexPath(row: row, section: 0))
    }

    /* func title(at row: Int) -> String? {
         cell(at: 1)?
         return cell(at: row)?.textLabel?.text
     } */

    /*
     func select(row: Int) {
         let indexPath = IndexPath(row: row, section: 0)
         selectRow(at: indexPath, animated: false, scrollPosition: .none)
         delegate?.tableView?(self, didSelectRowAt: indexPath)
     }

     func deselect(row: Int) {
         let indexPath = IndexPath(row: row, section: 0)
         deselectRow(at: indexPath, animated: false)
         delegate?.tableView?(self, didDeselectRowAt: indexPath)
     }*/
}
