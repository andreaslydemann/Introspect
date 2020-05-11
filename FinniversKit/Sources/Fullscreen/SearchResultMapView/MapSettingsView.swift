//
//  Copyright © 2019 FINN.no. All rights reserved.
//

import UIKit

public protocol MapSettingsViewDelegate: AnyObject {
    func mapSettingsView(_ view: MapSettingsView, didSelect action: MapSettingsView.Action)
}

public final class MapSettingsView: UIView {

    public enum Action {
        case changeMapType
        case centerMap
    }

    public weak var delegate: MapSettingsViewDelegate?

    private lazy var mapTypeButton: UIButton = {
        let button = UIButton(withAutoLayout: true)
        button.setImage(UIImage(named: .info), for: .normal)
        button.tintColor = .btnPrimary
        button.addTarget(self, action: #selector(changeMapTypeButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var centerMapButton: UIButton = {
        let button = UIButton(withAutoLayout: true)
        button.setImage(UIImage(named: .distanceOutlined), for: .normal)
        button.addTarget(self, action: #selector(centerMapButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var divider: UIView = {
        let view = UIView(withAutoLayout: true)
        view.backgroundColor = .stone
        return view
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    public override func layoutSubviews() {
        super.layoutSubviews()

        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = .spacingS
        layer.shadowOpacity = 0.4

        layer.cornerRadius = .spacingS
        layer.backgroundColor = UIColor.bgPrimary.withAlphaComponent(0.8).cgColor
    }

    private func setup() {
        addSubview(mapTypeButton)
        addSubview(divider)
        addSubview(centerMapButton)

        NSLayoutConstraint.activate([
            mapTypeButton.topAnchor.constraint(equalTo: topAnchor, constant: .spacingS),
            mapTypeButton.widthAnchor.constraint(equalToConstant: 42),
            mapTypeButton.heightAnchor.constraint(equalToConstant: .spacingXL),
            mapTypeButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapTypeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapTypeButton.bottomAnchor.constraint(equalTo: divider.topAnchor, constant: -4),

            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor),
            divider.centerYAnchor.constraint(equalTo: centerYAnchor),

            centerMapButton.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 4),
            centerMapButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.spacingS),
            centerMapButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            centerMapButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            centerMapButton.widthAnchor.constraint(equalToConstant: 42),
            centerMapButton.heightAnchor.constraint(equalToConstant: .spacingXL),
            ])
    }

    // MARK: - Actions

    @objc private func changeMapTypeButtonTapped() {
        delegate?.mapSettingsView(self, didSelect: .changeMapType)
    }

    @objc private func centerMapButtonTapped() {
        delegate?.mapSettingsView(self, didSelect: .centerMap)

    }

}
