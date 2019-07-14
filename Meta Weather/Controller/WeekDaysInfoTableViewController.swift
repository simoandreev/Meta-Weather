//
//  WeekDaysInfoTableViewController.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 13.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit

class WeekDaysInfoTableViewController: UITableViewController {
	private let cellId = "DefaultTableViewCell"
	private let weekDaysSegue = "showWeekDaysInfo"
	private let hoursSegue = "showHour"
	private var locations = [Day]()

	var city: Location? {
		didSet {
			navigationItem.title = city?.title
			fetchData()
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
	
	private func fetchData() {
		if restorationIdentifier == "days" {
			ApiService.shared.fetchWeatherForecastDays(woeid: city?.woeid ?? 0, successHandler: { response in
				print(response)
				if let days = response.consolidated_weather {
					self.locations = days
					self.tableView.reloadData()
				}
			}) { (error) in
				print(error.localizedDescription)
			}
		} else {
			ApiService.shared.fetchWeatherForecastByHour(woeid: city?.woeid ?? 0, date: "2019/07/14", successHandler: { response in
				print(response)
				self.locations = response
				self.tableView.reloadData()
			}) { (error) in
				print(error.localizedDescription)
			}
		}
	}
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DefaultTableViewCell
		let day = locations[indexPath.row]
		cell.configure(dateField: day.applicable_date, conditionField: day.weather_state_name, maxTempField: String(day.max_temp), minTempField: String(day.min_temp), windSpeedField: day.wind_direction_compass)

        return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if restorationIdentifier == "days" {
			performSegue(withIdentifier: hoursSegue, sender: city)
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == hoursSegue {
			let viewController:WeekDaysInfoTableViewController = segue.destination as! WeekDaysInfoTableViewController
			viewController.city = sender as? Location

		}
	}

}
