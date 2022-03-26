//
//  SignViewController.swift
//  SignScreen
//
//  Created by Alley Pereira on 24/03/22.
//

import UIKit

class SignViewController: UIViewController {

	// MARK: - Model

	var rows: [Row] {
		formRows + buttonRows
	}

	var formRows: [TextFieldRow] {
		userDataFormRows + passwordsFormRows
	}

	let userDataFormRows = [
		TextFieldRow(labelText: "Full Name", icon: UIImage(systemName: "person")!),
		TextFieldRow(labelText: "Phone (with DDD)", icon: UIImage(systemName: "iphone.homebutton")!, keyboardType: .phonePad),
		TextFieldRow(labelText: "Email", icon: UIImage(systemName: "mail")!, keyboardType: .emailAddress)
	]

	let passwordsFormRows = [
		TextFieldRow(labelText: "Password", icon: UIImage(systemName: "lock")!, secureEntry: true),
		TextFieldRow(labelText: "Confirm Password", icon: UIImage(systemName: "lock")!, secureEntry: true)
	]

	lazy var buttonRows: [Row] = [
		SpacerRow(),
		ButtonRow(title: "Sign Up", style: .big, handler: { [weak self] in
			self?.signView.endEditing(true)
			self?.validateFieldsAndShowAlert()
		})
	]

	// MARK: - Views
	lazy var signView: FormView = FormView(
		frame: UIScreen.main.bounds,
		footerView: FooterView(
			footerText: "Already have an account?",
			buttonTitle: "Sign in",
			handler: { [weak self] in
				print("Sign In pressed")
				self?.popToRoot()
			}
		)
	)

	// MARK: - Decoupled DataSource & Delegate
	lazy var tableViewDataSource = TableViewDataSource(rows)
	lazy var tableViewDelegate = TableViewDelegate(
		viewForHeader: TableHeaderView(
			title: "Create Account",
			subtitle: "Please fill the input bellow here."
		),
		heightForHeader: 350 - (UIScreen.main.bounds.height / 4)
	)

	// MARK: - Life Cycle
	override func loadView() {
		super.loadView()
		self.view = signView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		signView.tableView.delegate = tableViewDelegate
		signView.tableView.dataSource = tableViewDataSource
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if let firstField = signView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TextFieldTableViewCell {
			firstField.startEditing()
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		setupArrowBackButton()
		self.navigationController?.isNavigationBarHidden = false
	}

	// MARK: - Helpers

	@objc func popToRoot() {
		self.navigationController?.popToRootViewController(animated: true)
	}

	func setupArrowBackButton() {
		navigationController?.navigationBar.backIndicatorImage = UIImage()
		navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
		let backArrow = UIBarButtonItem(
			image: UIImage(
				systemName: "arrow.left",
				withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
			),
			style: .done,
			target: self,
			action: #selector(popToRoot)
		)
		backArrow.tintColor = .cyanPrimary
		self.navigationController?.navigationBar.topItem?.backBarButtonItem = backArrow
	}

	private func showOKAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
		alert.addAction(okAction)
		self.present(alert, animated: true)
	}

	private func validateFieldsAndShowAlert() {
		let invalidFields = self.formRows.filter { !$0.isValid }

		if invalidFields.isEmpty {

			if self.passwordsFormRows[0].textValue == self.passwordsFormRows[1].textValue {
				self.showOKAlert(title: "You just Signed Up!", message: "Get ready to login") { _ in self.popToRoot() }
			} else {
				self.showOKAlert(title: "Passwords don't match", message: "Make sure that they are the same")
			}

		} else {
			let invalidFieldNames = invalidFields.map { $0.labelText }.joined(separator: "\n")
			self.showOKAlert(title: "Invalid Fields", message: "\(invalidFieldNames)")
		}
	}
}
