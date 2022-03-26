//
//  TextFieldRow.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import UIKit

class TextFieldRow: Row {

	var labelText: String
	let icon: UIImage
	let secureEntry: Bool
	let keyboardType: UIKeyboardType

	var textValue: String?

	var isValid: Bool {
		if let value = textValue, !value.isEmpty {
			if let regex = regexValidation() {
				return value.range(of: regex, options: .regularExpression) != nil
			}
			return true
		}
		return false
	}

	init(
		labelText: String,
		icon: UIImage,
		secureEntry: Bool = false,
		keyboardType: UIKeyboardType = .default
	) {
		self.labelText = labelText
		self.icon = icon
		self.secureEntry = secureEntry
		self.keyboardType = keyboardType
	}

	func makeCell() -> UITableViewCell {
		let cell = TextFieldTableViewCell()
		cell.configure(self, handler: { [weak self] value in self?.textValue = value })
		return cell
	}

	private func regexValidation() -> String? {

		if keyboardType == .emailAddress {
			return #"^\S+@\S+\.\S+$"#
		}

		if keyboardType == .phonePad {
			return #"^\(?\d{2}\)?[\s-]?[\s9]?\d{4}-?\d{4}$"#
		}

		if secureEntry {
			return #"(?=.{8,})"# + // At least 8 characters
			#"(?=.*[A-Z])"# + // At least one lowercase letter
			#"(?=.*[a-z])"# + // At least one lowercase letter
			#"(?=.*\d)"# + // At least one digit
			#"(?=.*[ !$%&?._-])"# // At least one special character
		}

		return nil
	}
}
