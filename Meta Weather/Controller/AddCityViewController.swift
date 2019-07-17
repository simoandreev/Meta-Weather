//
//  AddCityViewController.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 17.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit
import CoreData

class AddCityViewController: UIViewController {
	
	private let persistanceManager: PersistantManager = PersistantManager()
	
	@IBOutlet weak var addNewCityTextField: UITextField!
	override func viewDidLoad() {
        super.viewDidLoad()
    }
    
	@IBAction func addNewCity(_ sender: UIButton) {
		if let text = addNewCityTextField.text {
			ApiService.shared.searchingForExistingCityWeatherForecast(name: text) { [weak self] (response, error) in
				if let error = error {
					print("Failed to fetch data:", error)
					print(error.localizedDescription)
					return
				}
				if let response = response {
					if response.count > 0 {
						print(response)
						DispatchQueue.main.async {
							if let location = response.first {
								if let locationExist = self?.persistanceManager.someEntityExists(woeid: location.woeid) {
									if !locationExist {
										self?.persistanceManager.safe(location: location)
										print("Save City: \(self?.addNewCityTextField.text ?? "")")
										if let navController = self?.navigationController {
											navController.popViewController(animated: true)
										}
									}
								}
							}
						}
					} else {
						print("Does not exist data for that city, try again with another one.")
					}
				}
				
			}
		}
	}
}
