//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

public protocol FavoriteButtonViewModel {
    var title: String { get }
    var subtitle: String? { get }
    var isFavorite: Bool { get }
}

public protocol FavoriteButtonViewDelegate: AnyObject {
    func favoriteButtonDidSelect(_ favoriteButtonView: FavoriteButtonView, button: Button, viewModel: FavoriteButtonViewModel)
}

// This view is set up to support two kinds of favorite button layouts, that will be AB tested in different releases.
// Excess code will be removed when the test results are ready.
public class FavoriteButtonView: UIView {

    // MARK: - Public properties

    public weak var delegate: FavoriteButtonViewDelegate?

    // MARK: - Private properties

    private enum ABTestVariant {
        case buttonOnly
        case buttonWithCounter
    }

    private final let activeTestVariant: ABTestVariant = .buttonWithCounter

    private var viewModel: FavoriteButtonViewModel?
    private let buttonStyle = Button.Style.default.overrideStyle(borderColor: .btnDisabled)
    private let flatButtonStyle = Button.Style.flat.overrideStyle(margins: UIEdgeInsets.zero)

    private lazy var button: Button = {
        let button = Button(style: buttonStyle, size: .normal, withAutoLayout: true)
        button.titleEdgeInsets = UIEdgeInsets(leading: -.spacingXS)
        button.imageEdgeInsets = UIEdgeInsets(leading: -.spacingS)
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        button.adjustsImageWhenHighlighted = false
        return button
    }()

    private lazy var flatButton: Button = {
        let button = Button(style: flatButtonStyle, withAutoLayout: true)
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        button.titleEdgeInsets = UIEdgeInsets(leading: .spacingS)
        button.imageEdgeInsets = UIEdgeInsets(top: -.spacingXS)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        button.contentHorizontalAlignment = .leading
        button.adjustsImageWhenHighlighted = false
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [flatButton, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var subtitleLabel: Label = {
        let label = Label(style: .detail, withAutoLayout: true)
        label.textColor = .textSecondary
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()

    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) { fatalError() }

    // MARK: - Setup

    private func setup() {
        switch activeTestVariant {
        case .buttonOnly:
            addSubview(button)
            button.fillInSuperview()
        case .buttonWithCounter:
            addSubview(stackView)
            stackView.fillInSuperview()
        }
    }

    // MARK: - Public methods

    public func configure(with viewModel: FavoriteButtonViewModel) {
        self.viewModel = viewModel

        switch activeTestVariant {
        case .buttonOnly:
            button.setTitle(viewModel.title, for: .normal)
            let image = viewModel.isFavorite ? UIImage(named: .favoriteActiveSmall) : UIImage(named: .favoriteDefaultSmall)
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            button.imageView?.tintColor = .btnAction

        case .buttonWithCounter:
            flatButton.setTitle(viewModel.title, for: .normal)
            subtitleLabel.text = viewModel.subtitle
            let image = viewModel.isFavorite ? UIImage(named: .favoriteActive) : UIImage(named: .favoriteDefault)
            flatButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            flatButton.imageView?.tintColor = .btnAction
        }
    }

    // MARK: - Private methods

    @objc private func handleButtonTap() {
        guard let viewModel = viewModel else { return }
        delegate?.favoriteButtonDidSelect(self, button: button, viewModel: viewModel)
    }
}
