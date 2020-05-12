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
    
    private let closeButton = UIBarButtonItem(image: R.image.close(),
                                              style: .done,
                                              target: self,
                                              action: nil)

    private let moodLabel: Label = {
        let label = Label(style: .title2)
        label.text = "How are you feeling now?"
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: Label = {
        let label = Label(style: .body)
        label.text = "Jul 20th 2020"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var headlineView: UIView = {
        let container = UIView()
        let headlines = UIView()
        
        container.addSubviews(headlines)
        headlines.centerInSuperview()
        
        headlines.addSubviews(moodLabel, dateLabel)
        
        moodLabel.anchor(top: headlines.topAnchor,
                         leading: headlines.leadingAnchor,
                         bottom: nil,
                         trailing: headlines.trailingAnchor)
        
        dateLabel.anchor(top: moodLabel.bottomAnchor,
                         leading: headlines.leadingAnchor,
                         bottom: headlines.bottomAnchor,
                         trailing: headlines.trailingAnchor,
                         padding: .init(top: .spacingM))
        
        return container
    }()
    
    private lazy var moodRatingView: HappinessRatingView = {
        let view = HappinessRatingView(delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let hotlineLabel: Label = {
        let label = Label(style: .body)
        
        let boldText = "Suicide prevention hotline. "
        let attrs = [NSAttributedString.Key.font: UIFont.bodyStrong]
        let attributedString = NSMutableAttributedString(string: boldText)

        let normalText = "Call now"
        let normalString = NSMutableAttributedString(string: normalText, attributes: attrs)

        attributedString.append(normalString)
        label.attributedText = attributedString
        label.textAlignment = .center
        return label
    }()
    
    private let continueButton: Button = {
        let button = Button(style: .callToAction)
        button.setTitle("Continue", for: .normal)
        return button
    }()
    
    private func setupNavigationItems() {
        navigationItem.leftBarButtonItem = closeButton
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        let contentView = UIView()
        view.addSubviews(contentView, continueButton)
        
        contentView.anchor(top: view.topAnchor,
                           leading: view.layoutMarginsGuide.leadingAnchor,
                           bottom: continueButton.topAnchor,
                           trailing: view.layoutMarginsGuide.trailingAnchor)
        
        continueButton.anchor(top: nil,
                              leading: view.layoutMarginsGuide.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.layoutMarginsGuide.trailingAnchor)
        
        contentView.addSubviews(headlineView, moodRatingView, hotlineLabel)
        
        headlineView.anchor(top: contentView.topAnchor,
                            leading: contentView.leadingAnchor,
                            bottom: moodRatingView.topAnchor,
                            trailing: contentView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            moodRatingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moodRatingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moodRatingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        hotlineLabel.anchor(top: moodRatingView.centerYAnchor,
                            leading: contentView.leadingAnchor,
                            bottom: nil,
                            trailing: contentView.trailingAnchor,
                            padding: .init(top: .spacingXXL))
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
