//
//  HomeViewController.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 04/12/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit
import UI

class HomeViewController: UIViewController {
    
    init () {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let checkInListViewController: CheckInListViewController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = CheckInListViewController(collectionViewLayout: layout)
        return vc
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hi Andreas"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override open func loadView() {
        self.view = UIView()
        
        view.backgroundColor = .blue
        
        view.addSubview(checkInListViewController.view)
        view.addSubview(nameLabel)
        
        nameLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: checkInListViewController.view.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 100, left: 15, bottom: 0, right: 15))
        checkInListViewController.view.anchor(top: nameLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 15, bottom: 15, right: 15))

        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
