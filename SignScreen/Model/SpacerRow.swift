//
//  SpacerRow.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import UIKit

struct SpacerRow: Row {
	func makeCell() -> UITableViewCell {
		let cell = UITableViewCell()
		cell.selectionStyle = .none
		cell.backgroundColor = .clear
		return cell
	}
}
