//
//  TextFieldTableViewCell.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

	let iconImageView: UIImageView = UIImageView()

	let fieldNameLabel: UILabel = UILabel()

	let textField: UITextField = UITextField()
	var textFieldChangedHandler: ((String?) -> Void)?

	private var fieldNameLabelHeightConstraint: NSLayoutConstraint?

	init() {
		super.init(style: .default, reuseIdentifier: Self.className)
		setupViewCode()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(_ row: TextFieldRow, handler: ((String?) -> Void)?) {
		self.fieldNameLabel.text = row.labelText.uppercased()

		self.iconImageView.image = row.icon

		self.textField.keyboardType = row.keyboardType
		self.textField.isSecureTextEntry = row.secureEntry
		self.textFieldChangedHandler = handler

		self.textField.attributedPlaceholder = .init(
			string: row.labelText,
			attributes: [.foregroundColor: UIColor.secondaryText]
		)
	}

	func startEditing() {
		select()
		self.textField.becomeFirstResponder()
	}

	private func select() {
		fieldNameLabel.isHidden = false
		iconImageView.tintColor = .primaryText
		self.contentView.backgroundColor = .fieldHighlight
		fieldNameLabelHeightConstraint?.constant = 15
		animateChangesToLayout()
	}

	private func unselect() {
		fieldNameLabel.isHidden = true
		iconImageView.tintColor = .secondaryText
		self.contentView.backgroundColor = .clear
		fieldNameLabelHeightConstraint?.constant = 0
		animateChangesToLayout()
	}

	private func animateChangesToLayout() {
		UIView.animate(withDuration: 0.5) {
			(self.superview as? UITableView)?.beginUpdates()
			self.contentView.layoutIfNeeded()
			(self.superview as? UITableView)?.endUpdates()
		}
	}
}

extension TextFieldTableViewCell: ViewCode {
	func buildHierarchy() {
		self.contentView.addSubviews(iconImageView, fieldNameLabel, textField)
		self.contentView.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			iconImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
			iconImageView.centerYAnchor.constraint(equalTo: self.textField.centerYAnchor),
			iconImageView.widthAnchor.constraint(equalToConstant: 20),

			textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
			textField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
			textField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),

			fieldNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
			fieldNameLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -5),
			fieldNameLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
			fieldNameLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor)
		])

		let textFieldHeight = textField.heightAnchor.constraint(equalToConstant: 40)
		textFieldHeight.priority = .defaultLow
		textFieldHeight.isActive = true

		self.fieldNameLabelHeightConstraint = fieldNameLabel.heightAnchor.constraint(equalToConstant: 0)
		self.fieldNameLabelHeightConstraint?.priority = .defaultHigh
		self.fieldNameLabelHeightConstraint?.isActive = true
	}

	func configureViews() {

		selectionStyle = .none

		self.backgroundColor = .clear
		self.contentView.layer.cornerRadius = self.contentView.frame.height / 3

		iconImageView.contentMode = .scaleAspectFill
		iconImageView.tintColor = .primaryText

		fieldNameLabel.font = .systemFont(ofSize: 10, weight: .bold)
		fieldNameLabel.textColor = .primaryText

		textField.delegate = self
		textField.borderStyle = .none
		textField.font = .systemFont(ofSize: 16, weight: .bold)
		textField.textColor = .primaryText
		textField.tintColor = .primaryText

		self.unselect()
	}
}

extension TextFieldTableViewCell: UITextFieldDelegate {

	func textFieldDidBeginEditing(_ textField: UITextField) {
		select()
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		unselect()
		textFieldChangedHandler?(textField.text)
	}

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.endEditing(true)
	}
}
