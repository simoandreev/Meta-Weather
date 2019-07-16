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
	var locationsCD: [LocationCD]?
	private let cellId = "homeCell"
	private let weekDaysSegue = "showWeekDaysInfo"
	private let persistanceManager: PersistantManager = PersistantManager()
	//private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	private let defaultCityArray = [Location(title: "Sofia", woeid: 839722, consolidated_weather: []),
							Location(title: "NY", woeid: 2459115, consolidated_weather: []),
							Location(title: "Tokyo", woeid: 1118370, consolidated_weather: [])]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		self.navigationController?.navigationBar.prefersLargeTitles = true
		//self.tableView.register(WeekDaysTableVTableViewCell.self, forCellReuseIdentifier: cellId)
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
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == weekDaysSegue {
			let viewController:TemplateInfoTableViewController = segue.destination as! TemplateInfoTableViewController
			viewController.location = sender as? Location
			viewController.navigationItem.title = (sender as? Location)?.title
			
		}
	}

}

