//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public class SelfDeclarationView: UIView {

    // MARK: - Private properties

    private lazy var introductionLabel: Label = {
        let label = Label(style: .body, withAutoLayout: true)
        label.numberOfLines = 0
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(withAutoLayout: true)
        stackView.axis = .vertical
        stackView.spacing = .spacingL
        return stackView
    }()

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup

    private func setup() {
        stackView.addArrangedSubview(introductionLabel)
        stackView.setCustomSpacing(.spacingXL, after: introductionLabel)
        addSubview(stackView)
        stackView.fillInSuperview()
    }

    // MARK: - Public methods

    public func configure(with viewModel: SelfDeclarationViewModel) {
        introductionLabel.text = viewModel.introduction

        stackView.removeDeclarationItemSubviews()

        viewModel.items.forEach {
            let view = SelfDeclarationItemView(withAutoLayout: true)
            view.configure(with: $0)
            stackView.addArrangedSubview(view)
        }
    }
}

// MARK: - Private extensions

private extension UIStackView {
    func removeDeclarationItemSubviews() {
        arrangedSubviews.filter { $0 is SelfDeclarationView }.forEach { removeArrangedSubview($0) }
    }
}
