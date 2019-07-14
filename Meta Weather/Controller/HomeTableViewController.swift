//
//  ViewController.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 12.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
	private let cellId = "homeCell"
	private let weekDaysSegue = "showWeekDaysInfo"
	private let defaultCityArray = [Location(title: "Sofia", woeid: 839722, consolidated_weather: []),
							Location(title: "NY", woeid: 2459115, consolidated_weather: []),
							Location(title: "Tokyo", woeid: 1118370, consolidated_weather: [])]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.navigationController?.navigationBar.prefersLargeTitles = true
		//self.tableView.register(WeekDaysTableVTableViewCell.self, forCellReuseIdentifier: cellId)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return defaultCityArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		 let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
		
		cell.textLabel?.text = defaultCityArray[indexPath.row].title
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: weekDaysSegue, sender: defaultCityArray[indexPath.row])
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == weekDaysSegue {
			let viewController:WeekDaysInfoTableViewController = segue.destination as! WeekDaysInfoTableViewController
			viewController.city = sender as? Location
			
		}
	}

}

