//
//  LoginViewController.swift
//  SignScreen
//
//  Created by Alley Pereira on 25/03/22.
//

import UIKit

class LoginViewController: UIViewController {

	// MARK: - Model

	var rows: [Row] {
		formRows + buttonRows
	}

	let formRows: [TextFieldRow] = [
		TextFieldRow(labelText: "email", icon: UIImage(systemName: "mail")!),
		TextFieldRow(labelText: "password", icon: UIImage(systemName: "lock")!, secureEntry: true)
	]

	let buttonRows: [Row] = [
		SpacerRow(),
		ButtonRow(title: "login", style: .big, handler: {
			print("Login pressed")
		}),
		ButtonRow(title: "Forgot Password?", style: .small, handler: {
			print("Forgot Password pressed")
		})
	]

	// MARK: - Views
	lazy var loginView: FormView = FormView(
		frame: UIScreen.main.bounds,
		footerView: FooterView(
			footerText: "Don't have an account?",
			buttonTitle: "Sign up",
			handler: {
				print("Sign Up pressed")
				let signViewController = SignViewController()
				self.navigationController?.pushViewController(signViewController, animated: true)
			}
		)
	)

	// MARK: - Decoupled DataSource & Delegate
	lazy var tableViewDataSource = TableViewDataSource(rows)
	lazy var tableViewDelegate = TableViewDelegate(
		viewForHeader: TableHeaderView(
			image: UIImage(named: "enter-door")!,
			imageHeight: UIScreen.main.bounds.height / 4,
			title: "Login",
			subtitle: "Please sign in to continue."
		),
		heightForHeader: 350
	)

	// MARK: - Life Cycle
	override func loadView() {
		super.loadView()
		self.view = loginView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		loginView.tableView.delegate = tableViewDelegate
		loginView.tableView.dataSource = tableViewDataSource
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if let firstField = loginView.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TextFieldTableViewCell {
			firstField.startEditing()
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.isNavigationBarHidden = true
	}
}
