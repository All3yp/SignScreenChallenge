//
//  FormView.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import UIKit

class FormView: UIView {

	let tableView = UITableView()
	let footer: FooterView

	init(frame: CGRect, footerView: FooterView) {
		self.footer = footerView
		super.init(frame: frame)
		setupViewCode()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		self.endEditing(true)
	}
}

extension FormView: ViewCode {
	func buildHierarchy() {
		self.addSubviews(tableView, footer)
		self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: self.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.footer.topAnchor, constant: -10),
			tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
			tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),

			footer.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
			footer.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])

		let height = footer.heightAnchor.constraint(equalToConstant: 40)
		height.priority = .defaultLow
		height.isActive = true
	}

	func configureViews() {
		self.backgroundColor = .deepBlueBackground
		self.tableView.backgroundColor = .clear
		self.tableView.separatorStyle = .none
		self.tableView.bounces = false
	}

}
