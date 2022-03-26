//
//  ButtonRow.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import UIKit

struct ButtonRow: Row {

	enum Style {
		case big, small
	}

	let title: String
	let style: Style
	let handler: () -> Void

	func makeCell() -> UITableViewCell {
		let cell = ButtonTableViewCell(style: self.style)
		cell.configure(self)
		return cell
	}
}
