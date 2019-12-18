//
//  HomeViewControllerTests.swift
//  IntrospectTests
//
//  Created by Andreas Lüdemann on 17/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

@testable import Introspect
import UIKit
import XCTest

class HomeViewControllerTests: XCTestCase {
    func test_viewDidLoad_rendersGreeting() {
        XCTAssertEqual(makeSUT().greetingLabel.text, "")
        XCTAssertEqual(makeSUT(user: User(name: "Andreas")).greetingLabel.text, "Hi, Andreas")
    }

    // MARK: Helpers

    func makeSUT(user: User = User(name: "")) -> HomeViewController {
        let sut = HomeViewController(user: user)
        sut.loadViewIfNeeded()
        return sut
    }
}
