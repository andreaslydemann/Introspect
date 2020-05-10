//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

public protocol MinFinnProfileCellDelegate: AnyObject {
    func minFinnProfileCell(_ cell: MinFinnProfileCell, loadImageAt url: URL, with size: CGSize, completionHandler: @escaping (UIImage?) -> Void)
}

public class MinFinnProfileCell: UITableViewCell {

    weak var delegate: MinFinnProfileCellDelegate?

    private lazy var identityView: IdentityView = {
        let view = IdentityView(viewModel: nil)
        view.delegate = self
        view.gestureRecognizers?.forEach({ view.removeGestureRecognizer($0) })
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: nil)
    }

    func configure(with model: MinFinnProfileCellModel?) {
        delegate = model?.delegate
        identityView.viewModel = model
    }
}

extension MinFinnProfileCell: IdentityViewDelegate {
    public func identityViewWasTapped(_ identityView: IdentityView) {}

    public func identityView(_ identityView: IdentityView, loadImageWithUrl url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        let scale = UIScreen.main.scale

        let size = CGSize(
            width: IdentityView.profileImageSize * scale,
            height: IdentityView.profileImageSize * scale
        )

        delegate?.minFinnProfileCell(self, loadImageAt: url, with: size, completionHandler: completionHandler)
    }
}

private extension MinFinnProfileCell {
    func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        separatorInset = UIEdgeInsets(leading: UIScreen.main.bounds.width)

        contentView.addSubview(identityView)
        identityView.fillInSuperview(
            insets: UIEdgeInsets(top: 0, left: .spacingM, bottom: 0, right: -.spacingM)
        )
    }
}
