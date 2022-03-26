//
//  UIView+Extensions.swift
//  SignScreen
//
//  Created by Alley Pereira on 24/03/22.
//

import UIKit

extension UIView {
	public func addSubviews(_ subviews: UIView...) {
		subviews.forEach(addSubview)
	}
}
