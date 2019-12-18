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

class CheckInListViewControllerTest: XCTestCase {
    func test_viewDidLoad_rendersCheckIns() {
        XCTAssertEqual(makeSUT().collectionView.numberOfItems(inSection: 0), 1)

        XCTAssertEqual(makeSUT(checkIns: [CheckIn(date: Date())]).collectionView.numberOfItems(inSection: 0), 1)

        XCTAssertEqual(makeSUT(checkIns:
            [CheckIn(date: Date(fromString: "2019-03-25", format: .isoDate)!),
             CheckIn(date: Date(fromString: "2009-08-11", format: .isoDate)!)])
            .collectionView.numberOfItems(inSection: 0), 3)
    }

    /*
     func test_viewDidLoad_rendersOptionsText() {
     XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
     XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
     }*/

    // MARK: Helpers

    func makeSUT(checkIns: [CheckIn] = []) -> CheckInListViewController {
        let sut = CheckInListViewController(checkIns: checkIns)
        sut.loadViewIfNeeded()
        return sut
    }
}
