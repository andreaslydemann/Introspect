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
    
    let okButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: nil)
    
    let moodLabel: Label = {
        let label = Label(style: .title2)
        label.text = "How are you feeling now?"
        return label
    }()
    
    private lazy var moodRatingView: HappinessRatingView = {
        let view = HappinessRatingView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let hotlineLabel: Label = {
        let label = Label(style: .bodyRegular)
        label.text = "Hotline"
        return label
    }()
    
    let continueButton: Button = {
        let button = Button(style: .default)
        button.setTitle("Continue", for: .normal)
        return button
    }()
    
    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = okButton
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(moodLabel, moodRatingView, hotlineLabel, continueButton)
        
        moodLabel.anchor(top: nil,
                         leading: view.layoutMarginsGuide.leadingAnchor,
                         bottom: moodRatingView.topAnchor,
                         trailing: view.layoutMarginsGuide.trailingAnchor,
                         padding: .init(bottom: .spacingXXL))
        
        NSLayoutConstraint.activate([
            moodRatingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            moodRatingView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            moodRatingView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
        
        hotlineLabel.anchor(top: moodRatingView.bottomAnchor,
                            leading: view.layoutMarginsGuide.leadingAnchor,
                            bottom: nil,
                            trailing: view.layoutMarginsGuide.trailingAnchor,
                            padding: .init(top: .spacingXXL))
        
        continueButton.anchor(top: nil,
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
