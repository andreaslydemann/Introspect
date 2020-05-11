//
//  Copyright © 2019 FINN AS. All rights reserved.
//

import UIKit

public protocol MinFinnViewDataSource: AnyObject {
    func numberOfSections(in view: MinFinnView) -> Int
    func minFinnView(_ view: MinFinnView, numberOfRowsInSection section: Int) -> Int
    func minFinnView(_ view: MinFinnView, modelForRowAt indexPath: IndexPath) -> MinFinnCellModel
}

public protocol MinFinnViewDelegate: AnyObject {
    func minFinnView(_ view: MinFinnView, didSelectModelAt indexPath: IndexPath)
    func minFinnView(_ view: MinFinnView, didPullToRefreshingUsing refreshControl: UIRefreshControl)
}

public class MinFinnView: UIView {

    // MARK: - Public properties

    public weak var dataSource: MinFinnViewDataSource?
    public weak var delegate: MinFinnViewDelegate?

    // MARK: - Private properties

    private var refreshOnGestureEnded = false

    private lazy var refreshControl: UIRefreshControl = {
        let controller = RefreshControl(frame: .zero)
        controller.delegate = self
        return controller
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .bgPrimary
        tableView.separatorColor = .tableViewSeparator
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        tableView.register(MinFinnProfileCell.self)
        tableView.register(MinFinnVerifyCell.self)
        tableView.register(IconTitleTableViewCell.self)
        tableView.register(BasicTableViewCell.self)
        tableView.refreshControl = refreshControl
        tableView.panGestureRecognizer.addTarget(self, action: #selector(handlePan(gesture:)))
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return tableView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended, .cancelled, .failed:
            guard refreshOnGestureEnded else { return }
            refreshOnGestureEnded = false
            delegate?.minFinnView(self, didPullToRefreshingUsing: refreshControl)
        default:
            return
        }
    }
}

// MARK: - Publit methods
public extension MinFinnView {
    var indexPathForSelectedRow: IndexPath? {
        tableView.indexPathForSelectedRow
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }

    func reloadData() {
        tableView.reloadData()
    }

    func reloadRows(at indexPaths: [IndexPath], animated: Bool = true) {
        tableView.reloadRows(at: indexPaths, with: animated ? .automatic : .none)
    }

    func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        tableView.cellForRow(at: indexPath)
    }

    func setContentOffset(_ offset: CGPoint, animated: Bool = true) {
        tableView.setContentOffset(offset, animated: animated)
    }
}

// MARK: - UITableViewDataSource
extension MinFinnView: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        dataSource?.numberOfSections(in: self) ?? 0
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.minFinnView(self, numberOfRowsInSection: section) ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource?.minFinnView(self, modelForRowAt: indexPath)

        switch model {
        case let profileModel as MinFinnProfileCellModel:
            let cell = tableView.dequeue(MinFinnProfileCell.self, for: indexPath)
            cell.configure(with: profileModel)
            return cell
        case let verifyModel as MinFinnVerifyCellModel:
            let cell = tableView.dequeue(MinFinnVerifyCell.self, for: indexPath)
            cell.configure(with: verifyModel)
            return cell
        case let iconModel as IconTitleTableViewCellViewModel:
            let cell = tableView.dequeue(IconTitleTableViewCell.self, for: indexPath)
            cell.configure(with: iconModel)
            return cell
        default:
            let cell = tableView.dequeue(BasicTableViewCell.self, for: indexPath)

            if let model = model {
                cell.configure(with: model)
            }

            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension MinFinnView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.minFinnView(self, didSelectModelAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource?.minFinnView(self, modelForRowAt: indexPath) {
        case is MinFinnProfileCellModel, is MinFinnVerifyCellModel:
            return UITableView.automaticDimension
        default:
            return 48
        }
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return .spacingM
        default: return .spacingXL
        }
    }
}

extension MinFinnView: RefreshControlDelegate {
    public func refreshControlDidBeginRefreshing(_ refreshControl: RefreshControl) {
        refreshOnGestureEnded = true
    }
}
