//
//  Row.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import UIKit

protocol Row {
	var isValid: Bool { get }
	func makeCell() -> UITableViewCell
}

extension Row {
	var isValid: Bool {
		true
	}
}
