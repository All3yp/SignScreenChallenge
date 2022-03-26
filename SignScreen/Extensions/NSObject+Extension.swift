//
//  NSObject+Extension.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import Foundation

extension NSObject {
  var className: String {
	return String(describing: type(of: self))
  }

  class var className: String {
	return String(describing: self)
  }
}
