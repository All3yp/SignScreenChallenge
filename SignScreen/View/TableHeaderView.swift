//
//  LoginHeaderView.swift
//  SignScreen
//
//  Created by Alley Pereira on 24/03/22.
//

import UIKit

class TableHeaderView: UIView {

	private let logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	private let headerLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
		label.isAccessibilityElement = true
		label.textColor = .white
		return label
	}()

	private let descriptionHeaderLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
		label.isAccessibilityElement = true
		label.textColor = .gray
		return label
	}()

	private let imageHeight: CGFloat

	private var imageHeightConstraint: NSLayoutConstraint?

	var hasImage: Bool {
		(logoImageView.image != nil)
	}

	init(image: UIImage? = nil, imageHeight: CGFloat? = nil, title: String, subtitle: String) {
		self.imageHeight = imageHeight ?? 0

		super.init(frame: .zero)

		setupViewCode()

		if let image = image {
			self.logoImageView.image = image
		} else {
			imageHeightConstraint?.constant = 0
		}

		self.headerLabel.text = title
		self.descriptionHeaderLabel.text = subtitle
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

extension TableHeaderView: ViewCode {

	func buildHierarchy() {
		self.addSubviews(
			logoImageView,
			headerLabel,
			descriptionHeaderLabel
		)
		self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			logoImageView.widthAnchor.constraint(equalToConstant: 300),

			headerLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
			headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
			headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),

			descriptionHeaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
			descriptionHeaderLabel.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
			descriptionHeaderLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor)
		])

		self.imageHeightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: imageHeight)
		self.imageHeightConstraint?.isActive = true
	}

}
