//
//  LoginFooterView.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import UIKit

class FooterView: UIView {

	lazy var button: UIButton = {
		let button = UIButton()
		button.setTitleColor(.cyanPrimary, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
		return button
	}()

	let label: UILabel = {
		let label = UILabel()
		label.textColor = .secondaryText
		label.font = .systemFont(ofSize: 16.0, weight: .regular)
		return label
	}()

	lazy var footer: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [label, button])
		stack.axis = .horizontal
		stack.spacing = 3
		stack.distribution = .fillProportionally
		stack.alignment = .center
		return stack
	}()

	private let handler: (() -> Void)?

	init(footerText: String, buttonTitle: String, handler: (() -> Void)?) {
		self.handler = handler

		super.init(frame: .zero)

		setupViewCode()

		self.label.text = footerText
		self.button.setTitle(buttonTitle, for: .normal)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc func signUpAction() {
		handler?()
	}

}

extension FooterView: ViewCode {
	func buildHierarchy() {
		self.addSubview(footer)
		footer.translatesAutoresizingMaskIntoConstraints = false
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			footer.topAnchor.constraint(equalTo: self.topAnchor),
			footer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			footer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			footer.trailingAnchor.constraint(equalTo: self.trailingAnchor)
		])
	}

	func configureViews() {
		button.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
	}
}
