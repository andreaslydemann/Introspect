//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

/// Delegate to handle interaction happening inside the cell
public protocol UserAdEmphasizedActionTableViewCellDelegate: AnyObject {
    func userAdEmphasizedActionTableViewCell(_ cell: UserAdEmphasizedActionTableViewCell, buttonWasTapped: Button)
    func userAdEmphasizedActionTableViewCell(_ cell: UserAdEmphasizedActionTableViewCell, cancelButtonWasTapped: Button)
    func userAdEmphasizedActionTableViewCell(_ cell: UserAdEmphasizedActionTableViewCell, closeButtonWasTapped: UIButton)
    func userAdEmphasizedActionTableViewCell(_ cell: UserAdEmphasizedActionTableViewCell, textFor rating: HappinessRating) -> String?
    func userAdEmphasizedActionTableViewCell(_ cell: UserAdEmphasizedActionTableViewCell, didSelectRating rating: HappinessRating)
}

public class UserAdEmphasizedActionTableViewCell: UITableViewCell {
    // MARK: - External properties

    public var model: UserAdTableViewCellViewModel?

    /// The loading color is used to fill the image view while we load the image.
    public var loadingColor: UIColor? {
        didSet {
            userAdDetailsView.loadingColor = loadingColor
        }
    }

    public weak var delegate: UserAdEmphasizedActionTableViewCellDelegate?

    /// A data source for the loading of the image
    public weak var remoteImageViewDataSource: RemoteImageViewDataSource? {
        didSet {
            userAdDetailsView.adImageViewDataSource = remoteImageViewDataSource
        }
    }

    /// Informs the cell whether it should display the available action or not
    public var shouldShowAction = true {
        didSet {
            actionWrapper.isHidden = !shouldShowAction
        }
    }

    // MARK: - Internal properties

    private static let cornerRadius: CGFloat = 12
    private static let actionButtonIconWidth: CGFloat = 12

    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(withAutoLayout: true)
        stack.axis = .vertical
        return stack
    }()

    private lazy var adWrapperView: UIView = {
        let view = UIView(withAutoLayout: false)
        view.backgroundColor = .clear
        return view
    }()

    private lazy var actionWrapper: UIView = {
        let view = UIView(withAutoLayout: false)
        view.backgroundColor = .clear
        return view
    }()

    private lazy var userAdDetailsView: UserAdDetailsView = {
        let view = UserAdDetailsView(withAutoLayout: true)
        view.backgroundColor = .bgPrimary
        view.layer.cornerRadius = UserAdEmphasizedActionTableViewCell.cornerRadius
        return view
    }()

    private lazy var actionTitleLabel: Label = {
        let label = Label(style: .bodyStrong, withAutoLayout: true)
        label.numberOfLines = 0
        return label
    }()

    private lazy var actionDescriptionLabel: Label = {
        let label = Label(style: .caption, withAutoLayout: true)
        label.numberOfLines = 0
        return label
    }()

    private lazy var actionButton: Button = {
        let button = Button(style: .default, size: .small, withAutoLayout: true)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: Button = {
        let button = Button(style: .flat, size: .small, withAutoLayout: true)
        button.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    private lazy var actionButtonIcon: UIImageView = {
        let imageView = UIImageView(withAutoLayout: true)
        imageView.image = UIImage(named: .webview)
        return imageView
    }()

    private lazy var gradientWrapper: UIView = {
        let view = UIView(withAutoLayout: true)
        view.backgroundColor = .bgTertiary
        return view
    }()

    private lazy var gradientLayer: CALayer = {
        let layer = CAGradientLayer()
        let color = UIColor.bgPrimary.withAlphaComponent(0.75)
        layer.colors = [UIColor.bgTertiary.cgColor, color.cgColor]
        layer.locations = [0.1, 1.0]
        return layer
    }()

    private lazy var ratingView: UserAdsRatingView = {
        let ratingView = UserAdsRatingView(delegate: self)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.alpha = 0
        ratingView.transform = CGAffineTransform(translationX: bounds.maxX, y: 0)
        return ratingView
    }()

    // MARK: - Setup

    private func setupView() {
        isAccessibilityElement = true
        contentView.backgroundColor = .bgTertiary
        accessoryType = .none
        selectionStyle = .none
        separatorInset = UIEdgeInsets(leading: UserAdTableViewCell.Style.default.imageSize + .spacingXL + .spacingS)

        contentView.addSubview(contentStack)
        contentView.addSubview(ratingView)

        contentStack.addArrangedSubview(adWrapperView)
        contentStack.addArrangedSubview(actionWrapper)

        adWrapperView.addSubview(userAdDetailsView)

        actionWrapper.addSubview(actionTitleLabel)
        actionWrapper.addSubview(actionDescriptionLabel)
        actionWrapper.addSubview(actionButton)
        actionWrapper.addSubview(cancelButton)
        actionWrapper.addSubview(gradientWrapper)
        gradientWrapper.layer.addSublayer(gradientLayer)

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0, priority: .init(999)),

            userAdDetailsView.topAnchor.constraint(equalTo: adWrapperView.topAnchor, constant: .spacingM),
            userAdDetailsView.leadingAnchor.constraint(equalTo: adWrapperView.leadingAnchor, constant: .spacingM),
            userAdDetailsView.trailingAnchor.constraint(equalTo: adWrapperView.trailingAnchor, constant: -.spacingM),
            userAdDetailsView.bottomAnchor.constraint(equalTo: adWrapperView.bottomAnchor, constant: -.spacingM),

            ratingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ratingView.bottomAnchor.constraint(equalTo: actionWrapper.bottomAnchor),

            actionTitleLabel.leadingAnchor.constraint(equalTo: actionWrapper.leadingAnchor, constant: .spacingM),
            actionTitleLabel.trailingAnchor.constraint(equalTo: actionWrapper.trailingAnchor, constant: -.spacingM),
            actionTitleLabel.topAnchor.constraint(equalTo: actionWrapper.topAnchor),

            actionDescriptionLabel.leadingAnchor.constraint(equalTo: actionWrapper.leadingAnchor, constant: .spacingM),
            actionDescriptionLabel.trailingAnchor.constraint(equalTo: actionWrapper.trailingAnchor, constant: -.spacingM),
            actionDescriptionLabel.topAnchor.constraint(equalTo: actionTitleLabel.bottomAnchor, constant: .spacingS),

            actionButton.leadingAnchor.constraint(equalTo: actionWrapper.leadingAnchor, constant: .spacingM),
            actionButton.topAnchor.constraint(equalTo: actionDescriptionLabel.bottomAnchor, constant: 24),

            cancelButton.centerYAnchor.constraint(equalTo: actionButton.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: actionButton.trailingAnchor, constant: .spacingXS),

            gradientWrapper.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: .spacingS),
            gradientWrapper.heightAnchor.constraint(equalToConstant: 24),
            gradientWrapper.leadingAnchor.constraint(equalTo: actionWrapper.leadingAnchor),
            gradientWrapper.trailingAnchor.constraint(equalTo: actionWrapper.trailingAnchor),
            gradientWrapper.bottomAnchor.constraint(equalTo: actionWrapper.bottomAnchor)
        ])
    }

    private func setupActionButtonIcon() {
        let margins = UIEdgeInsets(
            top: .spacingS,
            leading: .spacingM,
            bottom: .spacingS,
            trailing: .spacingM + UserAdEmphasizedActionTableViewCell.actionButtonIconWidth
        )

        actionButton.style = actionButton.style.overrideStyle(margins: margins)

        actionButton.addSubview(actionButtonIcon)

        NSLayoutConstraint.activate([
            actionButtonIcon.widthAnchor.constraint(equalToConstant: UserAdEmphasizedActionTableViewCell.actionButtonIconWidth),
            actionButtonIcon.heightAnchor.constraint(equalToConstant: UserAdEmphasizedActionTableViewCell.actionButtonIconWidth),
            actionButtonIcon.trailingAnchor.constraint(equalTo: actionButton.trailingAnchor, constant: -.spacingS - actionButton.style.borderWidth),
            actionButtonIcon.centerYAnchor.constraint(equalTo: actionButton.centerYAnchor)
        ])
    }

    // MARK: - Superclass Overrides

    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientWrapper.bounds
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        userAdDetailsView.resetContent()
        actionTitleLabel.text = nil
        actionDescriptionLabel.text = nil
        actionButton.setTitle(nil, for: .normal)
        cancelButton.setTitle(nil, for: .normal)
        cancelButton.isHidden = true
    }

    // MARK: - Public methods

    public func configure(with model: UserAdTableViewCellViewModel) {
        self.model = model

        setupView()

        accessibilityLabel = model.accessibilityLabel

        userAdDetailsView.configure(with: .default, model: model)

        ratingView.model = model.ratingViewModel

        actionTitleLabel.text = model.actionViewModel?.title
        actionDescriptionLabel.text = model.actionViewModel?.description
        actionButton.setTitle(model.actionViewModel?.buttonTitle, for: .normal)
        cancelButton.setTitle(model.actionViewModel?.cancelButtonTitle, for: .normal)

        if let actionViewModel = model.actionViewModel {
            cancelButton.isHidden = actionViewModel.cancelButtonTitle == nil

            if actionViewModel.isExternalAction {
                setupActionButtonIcon()
            }
        }
    }

    // MARK: - Selectors

    @objc private func buttonTapped(_ sender: Button) {
        delegate?.userAdEmphasizedActionTableViewCell(self, buttonWasTapped: sender)
    }

    @objc private func cancelButtonTapped(_ sender: Button) {
        delegate?.userAdEmphasizedActionTableViewCell(self, cancelButtonWasTapped: sender)
    }

    // MARK: - Public

    public func showRatingView(completion: (() -> Void)? = nil) {
        let leftSlideTransform = CGAffineTransform(translationX: -bounds.maxX, y: 0)

            UIView.animate(withDuration: 0.2, animations: {
                self.adWrapperView.transform = leftSlideTransform
                self.actionWrapper.transform = leftSlideTransform

                UIView.animate(withDuration: 0.1, animations: {
                    // In the initalization of the RatingView
                    // it performs a X-axis translation equal to bounds.maxX
                    // Hence calling .identity here
                    self.ratingView.transform = .identity
                    self.ratingView.alpha = 1
                }, completion: { _ in
                    completion?()
            })
        })
    }

    public func hideRatingView(completion: (() -> Void)? = nil) {
        let rightSlideTransform = CGAffineTransform(translationX: bounds.maxX, y: 0)

        UIView.animate(withDuration: 0.2, animations: {
            self.ratingView.transform = rightSlideTransform

            UIView.animate(withDuration: 0.1, animations: {
                self.adWrapperView.transform = .identity
                self.actionWrapper.transform = .identity
                self.ratingView.alpha = 0
            }, completion: { _ in
                completion?()
            })
        })
    }
}

// MARK: - ImageLoading

extension UserAdEmphasizedActionTableViewCell: ImageLoading {
    public func loadImage() {
        userAdDetailsView.loadImage()
    }
}

// MARK: - UserAdsRatingViewDelegate

extension UserAdEmphasizedActionTableViewCell: UserAdsRatingViewDelegate {
    public func ratingView(_ userAdsRatingView: UserAdsRatingView, didTapCloseButton button: UIButton) {
        delegate?.userAdEmphasizedActionTableViewCell(self, closeButtonWasTapped: button)
    }

    public func ratingView(_ userAdsRatingView: UserAdsRatingView, didSelectRating rating: HappinessRating) {
        delegate?.userAdEmphasizedActionTableViewCell(self, didSelectRating: rating)
    }

    public func ratingView(_ userAdsRatingView: UserAdsRatingView, textFor rating: HappinessRating) -> String? {
        return delegate?.userAdEmphasizedActionTableViewCell(self, textFor: rating)
    }
}
