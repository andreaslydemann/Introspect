//
//  ReflectionListViewControllerTests.swift
//  IntrospectTests
//
//  Created by Andreas Lüdemann on 17/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

@testable import Introspect
import DateHelper
import UIKit
import XCTest

class ReflectionListViewControllerTests: XCTestCase {
    let oneReflectionToday = [Reflection(date: Date())]
    let twoPastReflections = [Reflection(date: Date(fromString: "2001-01-01", format: .isoDate)!),
                           Reflection(date: Date(fromString: "2001-01-01", format: .isoDate)!)]

    func test_viewDidLoad_rendersReflections() {
        XCTAssertEqual(makeSUT().collectionView.numberOfItems(inSection: 0), 1)
        XCTAssertEqual(makeSUT(reflections: oneReflectionToday).collectionView.numberOfItems(inSection: 0), 1)
        XCTAssertEqual(makeSUT(reflections: twoPastReflections)
            .collectionView.numberOfItems(inSection: 0), 3)
    }

    func test_viewDidLoad_configuresCreateCell() {
        XCTAssertNotNil(makeSUT().collectionView.cell(at: 0) as? NewReflectionCell)
        XCTAssertNotNil(makeSUT(reflections: twoPastReflections).collectionView.cell(at: 0) as? NewReflectionCell)
    }

    func test_viewDidLoad_configuresCompletedCell() {
        let cell = makeSUT(reflections: twoPastReflections).collectionView.cell(at: 1) as? PastReflectionCell

        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.dayLabel.text, "22")
        XCTAssertEqual(cell?.monthLabel.text, "Jan")
    }

    // MARK: Helpers

    func makeSUT(reflections: [Reflection] = []) -> ReflectionListViewController {
        let sut = ReflectionListViewController(reflections: reflections)
        sut.loadViewIfNeeded()
        sut.collectionView.layoutIfNeeded()
        return sut
    }
}
