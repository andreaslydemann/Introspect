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

    func test_viewDidLoad_withoutCheckIns_configuresCell() {
        let cell = makeSUT().collectionView.cell(at: 0) as? CreateCheckInCell

        XCTAssertNotNil(cell)
    }

    func test_viewDidLoad_withCheckIns_configuresCell() {
        let sut = makeSUT(checkIns: [CheckIn(date: Date(fromString: "2001-01-01", format: .isoDate)!)])

        let cell = sut.collectionView.cell(at: 0) as? CreateCheckInCell

        XCTAssertNotNil(cell)
        // XCTAssertEqual(cell?.questionLabel.text, "Q1")
        // XCTAssertEqual(cell?.answerLabel.text, "A1")
        // XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
    }

    // MARK: Helpers

    func makeSUT(checkIns: [CheckIn] = []) -> CheckInListViewController {
        let sut = CheckInListViewController(checkIns: checkIns)
        sut.loadViewIfNeeded()
        sut.collectionView.layoutIfNeeded()
        return sut
    }
}
