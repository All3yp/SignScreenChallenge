//
//  TableViewDataSource.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {

	var rows: [Row]

	init(_ rows: [Row]) {
		self.rows = rows
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		rows.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		rows[indexPath.row].makeCell()
	}
}
