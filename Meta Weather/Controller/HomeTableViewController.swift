//
//  ViewController.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 12.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController {
	private var locationsCD: [LocationCD]?
	private let cellId = "homeCell"
	private let weekDaysSegue = "showWeekDaysInfo"
	private let persistanceManager: PersistantManager = PersistantManager()
	private let defaultCityArray = [Location(title: "Sofia", woeid: 839722, consolidatedWeather: []),
							Location(title: "NY", woeid: 2459115, consolidatedWeather: []),
							Location(title: "Tokyo", woeid: 1118370, consolidatedWeather: [])]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		for location in defaultCityArray {
			if !persistanceManager.someEntityExists(woeid: location.woeid) {
				persistanceManager.safe(location: location)
			}
		}
		locationsCD = persistanceManager.loadLocations()
		self.tableView.reloadData()
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return locationsCD?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		 let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
		
		cell.textLabel?.text = locationsCD?[indexPath.row].title
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let locationsCoreData = locationsCD?[indexPath.row]
		if let locationsCoreData = locationsCoreData {
			performSegue(withIdentifier: weekDaysSegue, sender: persistanceManager.convertToLocation(locationCD: locationsCoreData))
		}
	}
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			if let locationItem = locationsCD?[indexPath.row] {
				if Int(locationItem.woeid) == 839722 || Int(locationItem.woeid) == 2459115 || Int(locationItem.woeid) == 1118370 {
					print("Can't Delete Default Location !!!")
				} else {
					print("Deleted")
					persistanceManager.deleteItem(object: locationItem)
					self.locationsCD?.remove(at: indexPath.row)
					self.tableView.reloadData()
				}
			}
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == weekDaysSegue {
			if let segueDestination = segue.destination as? TemplateInfoTableViewController {
				let viewController:TemplateInfoTableViewController = segueDestination
				viewController.location = sender as? Location
				viewController.navigationItem.title = (sender as? Location)?.title
			}
		}
	}

}

