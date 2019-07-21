//
//  AddCityViewController.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 17.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit
import CoreData
import NotificationBannerSwift

class AddCityViewController: UIViewController {
	
	private enum Constant {
		static let errorTitle = "Error"
		static let successTitle = "Success"
		static let newCityMessage = "New city: "
		static let successfullySavedMessage = "is successfully saved."
		static let alreadyExistWarrningMessage = "This city already exist, try again with another one."
		static let doesNotExistMessage = "Does not exist data for that city, try again with another one."
	}

	@IBOutlet private weak var addNewCityTextField: UITextField!
	
	private let persistanceManager: PersistantManager = PersistantManager()
	private var location: Location?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.hideKeyboardWhenTappedAround()
    }
    
	@IBAction func addNewCity(_ sender: UIButton) {
		self.showSpinner(onView: self.view)
		if let text = addNewCityTextField.text {
			ApiService.shared.searchingForExistingCityWeatherForecast(name: text) { [weak self] (response, error) in
				if let error = error {
					self?.removeSpinner()
					DispatchQueue.main.async {
						let banner = NotificationBanner(title: Constant.errorTitle, subtitle: error.localizedDescription, style: .warning)
						banner.show()
					}
					return
				}
				if let response = response {
					if response.count > 0 {
						DispatchQueue.main.async {
							if let location = response.first {
								if let locationExist = self?.persistanceManager.someEntityExists(woeid: location.woeid) {
									if !locationExist {
										self?.persistanceManager.save(location: location)
										let banner = NotificationBanner(title: Constant.successTitle, subtitle: "\(Constant.newCityMessage) \(location.title) \(Constant.successfullySavedMessage)", style: .success)
										banner.show()
										self?.removeSpinner()
										if let navController = self?.navigationController {
											navController.popViewController(animated: true)
										}
									} else {
										self?.removeSpinner()
										let banner = NotificationBanner(title: Constant.errorTitle, subtitle: Constant.alreadyExistWarrningMessage, style: .warning)
										banner.show()
									}
								}
							}
						}
					} else {
						self?.removeSpinner()
						DispatchQueue.main.async {
							let banner = NotificationBanner(title: Constant.errorTitle, subtitle: Constant.doesNotExistMessage, style: .warning)
							banner.show()
						}
					}
				}
			}
		}
	}
}
