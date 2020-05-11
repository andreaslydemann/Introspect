//
//  Copyright © 2020 FINN AS. All rights reserved.
//

import UIKit

public class TransactionHeaderView: UIView {
    weak var dataSource: RemoteImageViewDataSource? {
        didSet {
            imageView.dataSource = dataSource
        }
     }

    private lazy var titleLabel: Label = {
        let label = Label(style: .bodyStrong, withAutoLayout: true)
        label.numberOfLines = 3
        return label
     }()

    private lazy var detailLabel: Label = {
        let label = Label(style: .caption, withAutoLayout: true)
        label.numberOfLines = 1
        return label
    }()

     private lazy var imageView: RemoteImageView = {
        let imageView = RemoteImageView(withAutoLayout: true)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = (TransactionHeaderView.defaultImageSize / 2)
        return imageView
     }()

    private static var imageUrl = "https://images.finncdn.no/dynamic/default"
    private static var defaultImageSize: CGFloat = UIDevice.isIPad() ? 200 : 128

    private var loadingColor: UIColor? = .bgSecondary
    private var fallbackImage = UIImage(named: .noImage)

    private var model: TransactionHeaderViewModel

    public init(withAutoLayout autoLayout: Bool = false, model: TransactionHeaderViewModel) {
        self.model = model
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = !autoLayout
        setup()
    }

    public func loadImage() {
        guard let imagePath = model.imagePath else {
            imageView.image = fallbackImage
            return
        }

        let url = "\(TransactionHeaderView.imageUrl)/\(imagePath)"
        imageView.loadImage(
            for: url,
            imageWidth: TransactionHeaderView.defaultImageSize,
            loadingColor: loadingColor,
            fallbackImage: fallbackImage
        )
     }

     required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
     }

     private func setup() {
        backgroundColor = .clear

        titleLabel.text = model.title
        detailLabel.text = model.registrationNumber

        addSubview(imageView)

        let stackView = UIStackView(withAutoLayout: true)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = .spacingS
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: TransactionHeaderView.defaultImageSize),
            imageView.widthAnchor.constraint(equalToConstant: TransactionHeaderView.defaultImageSize),

            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: .spacingM),
            stackView.topAnchor.constraint(equalTo: imageView.centerYAnchor, constant: -.spacingS),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -.spacingL),

            bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: .spacingS),
         ])
     }
}
