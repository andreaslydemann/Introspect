//
//  MoodRatingViewController.swift
//  Introspect
//
//  Created by Andreas Lüdemann on 08/05/2020.
//  Copyright © 2020 Andreas Lüdemann. All rights reserved.
//

import UIKit
import FinniversKit

class MoodRatingViewController: UIViewController {
    
    let okButton = UIBarButtonItem(title: "OK",
                                   style: .plain, target: self, action: nil)
    
    let moodLabel: UILabel = {
        let label = UILabel()
        label.text = "How are you feeling now?"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var moodRatingView: HappinessRatingView = {
        let view = HappinessRatingView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let hotlineLabel: UILabel = {
        let label = UILabel()
        label.text = "Hotline"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let nextButton: Button = {
        let button = Button(style: .default)
        button.setTitle("Next", for: .normal)
        return button
    }()
    
    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = okButton
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(moodLabel, moodRatingView, hotlineLabel, nextButton)
        
        moodLabel.anchor(top: nil,
                         leading: view.layoutMarginsGuide.leadingAnchor,
                         bottom: moodRatingView.topAnchor,
                         trailing: view.layoutMarginsGuide.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 100, right: 0))
        
        NSLayoutConstraint.activate([
            moodRatingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            moodRatingView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            moodRatingView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        hotlineLabel.anchor(top: moodRatingView.bottomAnchor,
                            leading: view.layoutMarginsGuide.leadingAnchor,
                            bottom: nil,
                            trailing: view.layoutMarginsGuide.trailingAnchor,
                            padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        
        nextButton.anchor(top: nil,
                          leading: view.layoutMarginsGuide.leadingAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          trailing: view.layoutMarginsGuide.trailingAnchor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationItems()
    }
}

extension MoodRatingViewController: HappinessRatingViewDelegate {
    func happinessRatingView(_ happinessRatingView: HappinessRatingView, didSelectRating rating: HappinessRating) { }
    
    func happinessRatingView(_ happinessRatingView: HappinessRatingView, textFor rating: HappinessRating) -> String? {
        switch rating {
        case .angry:
            return "Angry"
        case .dissatisfied:
            return nil
        case .neutral:
            return "Neutral"
        case .happy:
            return nil
        case .love:
            return "Love"
        }
    }
}
