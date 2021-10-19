//
//  ListViewController.swift
//  iOSTemplate
//
//  Created by Johnnie Cheng on 17/10/21.
//

import UIKit
import Combine

class ListViewController<VM: ListViewModelProtocol>: BaseViewController<VM>,
                                                     ClassIdentifiable,
                                                     UITableViewDelegate
{

    @IBOutlet var tableView: UITableView!
    private var listDataSource: UITableViewDiffableDataSource<Int, ListEntity>!
    private var snapshot = NSDiffableDataSourceSnapshot<Int, ListEntity>()

    static func newInstance(viewModel: VM) -> ListViewController {
        let vc = ListViewController(nibName: "ListViewController",
                                    bundle: nil)
        vc.viewModel = viewModel

        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List View" // TODO: Localise
        setupUI()
        viewModel.getList()
    }

    private func setupUI() {
        ListCell.registerIn(tableView: tableView)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        snapshot.appendSections([0])

        viewModel.items.sink { items in
            if let items = items {
                self.snapshot.appendItems(items, toSection: 0)
                self.listDataSource.apply(self.snapshot, animatingDifferences: true)
            }
        }
        .store(in: &subscriptions)

        listDataSource = UITableViewDiffableDataSource(tableView: tableView)
        { tableView, indexPath, item -> UITableViewCell? in
            let cell = ListCell.dequeueIn(tableView: tableView, for: indexPath)
            cell.updateUI(item: item)
            return cell
        }
    }


    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = snapshot.itemIdentifiers[indexPath.row]
        // TODO: navigate
    }

}
