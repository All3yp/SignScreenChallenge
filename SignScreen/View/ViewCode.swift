//
//  ViewCode.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import Foundation

protocol ViewCode {
	func buildHierarchy()
	func setupConstraints()
	func configureViews()
}

extension ViewCode {

	func configureViews() { }

	func setupViewCode() {
		buildHierarchy()
		setupConstraints()
		configureViews()
	}

}
