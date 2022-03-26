//
//  TableViewDelegate.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {

	let headerView: TableHeaderView
	let heightForHeader: CGFloat

	init(viewForHeader: TableHeaderView, heightForHeader: CGFloat) {
		self.headerView = viewForHeader
		self.heightForHeader = heightForHeader
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		headerView
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		heightForHeader
	}
}
