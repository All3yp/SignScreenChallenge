//
//  ButtonTableViewCell.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

	private let button = UIButton()
	private var style: ButtonRow.Style
	private var handler: (() -> Void)?

	init(style: ButtonRow.Style) {
		self.style = style
		super.init(style: .default, reuseIdentifier: Self.className)
		setupViewCode()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(_ row: ButtonRow) {
		self.handler = row.handler
		button.setTitle(row.style == .big ? row.title.uppercased() : row.title.localizedCapitalized, for: .normal)
	}

	@objc private func buttonAction() {
		handler?()
	}

}

extension ButtonTableViewCell: ViewCode {
	func buildHierarchy() {
		self.contentView.addSubviews(button)
		button.translatesAutoresizingMaskIntoConstraints = false
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			button.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
			button.widthAnchor.constraint(equalToConstant: 250),
			button.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
			button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
		])

		let height = button.heightAnchor.constraint(equalToConstant: style == .big ? 70 : 40)
		height.priority = .defaultHigh
		height.isActive = true
	}

	func configureViews() {
		self.selectionStyle = .none
		self.backgroundColor = .clear

		button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

		switch style {
		case .big:
			button.setTitleColor(.deepBlueBackground, for: .normal)
			button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
			button.backgroundColor = .cyanPrimary
			button.layer.cornerRadius = 35
			button.clipsToBounds = true
		case .small:
			button.setTitleColor(.cyanPrimary, for: .normal)
		}
	}
}
