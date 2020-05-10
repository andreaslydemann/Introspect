//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

// MARK: - SaveSearchPromptViewDelegate

public protocol SaveSearchPromptViewDelegate: AnyObject {
    func saveSearchPromptView(_ saveSearchPromptView: SaveSearchPromptView, didAcceptSaveSearch: Bool)
}

// MARK: - SaveSearchPromptView

public class SaveSearchPromptView: UIView {

    // MARK: - Public properties

    public weak var delegate: SaveSearchPromptViewDelegate?

    // MARK: - Private properties

    private lazy var titleLabel: Label = {
        let label = Label(style: .captionStrong, withAutoLayout: true)
        label.textColor = .textPrimary
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var positiveButton: Button = {
        let button = Button(style: .utility, size: .small, withAutoLayout: true)
        button.addTarget(self, action: #selector(positiveButtonTapped), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return button
    }()

    private lazy var dismissButton: UIButton = {
        let button = UIButton(withAutoLayout: true)
        button.setImage(UIImage(named: .remove), for: .normal)
        button.tintColor = .textSecondary
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = .bgTertiary

        addSubview(titleLabel)
        addSubview(positiveButton)
        addSubview(dismissButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: .spacingS*3),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacingM),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.spacingM),

            positiveButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .spacingM),
            positiveButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            dismissButton.topAnchor.constraint(equalTo: topAnchor, constant: .spacingXS),
            dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.spacingXS),
            dismissButton.widthAnchor.constraint(equalToConstant: 28),
            dismissButton.heightAnchor.constraint(equalToConstant: 28),
        ])
    }

    // MARK: - Public methods

    public func configure(title: String, positiveButtonTitle: String) {
        titleLabel.text = title
        positiveButton.setTitle(positiveButtonTitle, for: .normal)
    }

    // MARK: - Private methods

    @objc private func positiveButtonTapped() {
        delegate?.saveSearchPromptView(self, didAcceptSaveSearch: true)
    }

    @objc private func dismissButtonTapped() {
        delegate?.saveSearchPromptView(self, didAcceptSaveSearch: false)
    }
}
