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
    let oneCheckInToday = [CheckIn(date: Date())]
    let twoPastCheckIns = [CheckIn(date: Date(fromString: "2001-01-01", format: .isoDate)!),
                           CheckIn(date: Date(fromString: "2001-01-01", format: .isoDate)!)]

    func test_viewDidLoad_rendersCheckIns() {
        XCTAssertEqual(makeSUT().collectionView.numberOfItems(inSection: 0), 1)
        XCTAssertEqual(makeSUT(checkIns: oneCheckInToday).collectionView.numberOfItems(inSection: 0), 1)
        XCTAssertEqual(makeSUT(checkIns: twoPastCheckIns)
            .collectionView.numberOfItems(inSection: 0), 3)
    }

    func test_viewDidLoad_configuresCreateCell() {
        XCTAssertNotNil(makeSUT().collectionView.cell(at: 0) as? CreateCheckInCell)
        XCTAssertNotNil(makeSUT(checkIns: twoPastCheckIns).collectionView.cell(at: 0) as? CreateCheckInCell)
    }

    func test_viewDidLoad_configuresCompletedCell() {
        let cell = makeSUT(checkIns: twoPastCheckIns).collectionView.cell(at: 1) as? PastCheckInCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.dayLabel.text, "22")
        XCTAssertEqual(cell?.monthLabel.text, "Jan")
    }

    // MARK: Helpers

    func makeSUT(checkIns: [CheckIn] = []) -> CheckInListViewController {
        let sut = CheckInListViewController(checkIns: checkIns)
        sut.loadViewIfNeeded()
        sut.collectionView.layoutIfNeeded()
        return sut
    }
}
