//
//  CheckInListViewControllerTests.swift
//  IntrospectTests
//
//  Created by Andreas Lüdemann on 17/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

@testable import Introspect
import DateHelper
import UIKit
import XCTest

class CheckInListViewControllerTests: XCTestCase {
    func test_viewDidLoad_rendersCheckIns() {
        XCTAssertEqual(makeSUT().collectionView.numberOfItems(inSection: 0), 1)

        XCTAssertEqual(makeSUT(checkIns: [CheckIn(date: Date())]).collectionView.numberOfItems(inSection: 0), 1)

        XCTAssertEqual(makeSUT(checkIns:
            [CheckIn(date: Date(fromString: "2019-03-25", format: .isoDate)!),
             CheckIn(date: Date(fromString: "2009-08-11", format: .isoDate)!)])
            .collectionView.numberOfItems(inSection: 0), 3)
    }

    func test_viewDidLoad_withNoCheckIns_configuresCell() {
        let sut = makeSUT(checkIns: [CheckIn(date: Date())])

        sut.collectionView.reloadData()
        sut.collectionView.layoutIfNeeded()

        let cell = sut.collectionView.cell(at: 0)

        XCTAssertNotNil(cell)
        
        //XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
    }

    // MARK: Helpers

    func makeSUT(checkIns: [CheckIn] = []) -> CheckInListViewController {
        let sut = CheckInListViewController(checkIns: checkIns)
        sut.loadViewIfNeeded()
        return sut
    }
}
