//
//  WeekDaysInfoTableViewController.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 13.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit

class TemplateInfoTableViewController: UITableViewController {
	private enum Constant {
		static let cellHeight: CGFloat = 230
		
		static let dayTitle = "Day"
		static let createdTitle = "Created"
		static let stateTitle = "State"
		static let windDirectionTitle = "Wind direction"
		static let maxTemperatureTitle = "Max"
		static let minTemperatureTitle = "Min"
		static let inputDatedFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
		static let outputDatedFormat = "yyyy-MM-dd HH:mm:ss"
		
		static let tableViewBackgroundColor = UIColor(red: 92/255, green: 140/255, blue: 206/255, alpha: 1.0)
	}
	private let cellId = "DefaultTableViewCell"
	private let weekDaysSegue = "showWeekDaysInfo"
	private let hoursSegue = "showHour"
	private var locations = [Day]()
	private var day: Day?
	
	private enum SelectedViewController: String {
		case WeatherForecastByDays = "days"
		case WeatherForecastByHours = "hours"
	}

	private var currentViewController: SelectedViewController?
	
	var location: Location? {
		didSet {
			if let vcID = self.restorationIdentifier {
				if vcID  == SelectedViewController.WeatherForecastByDays.rawValue {
					currentViewController = SelectedViewController.WeatherForecastByDays
				} else if vcID == SelectedViewController.WeatherForecastByHours.rawValue {
					currentViewController = SelectedViewController.WeatherForecastByHours
				}
			}
			fetchData()
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		tableView.tableFooterView = UIView()
		tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
	
	private func fetchData() {
		if currentViewController == SelectedViewController.WeatherForecastByDays {
			ApiService.shared.fetchWeatherForecastDays(woeid: location?.woeid ?? 0) { [weak self] (response, error) in
				if let error = error {
					print("Failed to fetch data:", error)
					print(error.localizedDescription)
					return
				}
				if let responseDays = response?.consolidatedWeather { 
					self?.locations = responseDays
					DispatchQueue.main.async {
						self?.tableView.reloadData()
					}
				}
				
			}
		} else {
			self.navigationItem.title = self.day?.applicableDate
			ApiService.shared.fetchWeatherForecastByHour(woeid: location?.woeid ?? 0, date: self.day?.applicableDate.convertDateFormater() ?? "") { [weak self] (response, error) in
				if let error = error {
					print("Failed to fetch data:", error)
					print(error.localizedDescription)
					return
				}
				if let responseHours = response {
					self?.locations = responseHours
					DispatchQueue.main.async {
						self?.tableView.reloadData()
					}
				}
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
		cell.backgroundColor = Constant.tableViewBackgroundColor
		let day = locations[indexPath.row]
		cell.configure(
			dateField: currentViewController == SelectedViewController.WeatherForecastByDays ? "\(Constant.dayTitle): \(day.applicableDate)" : "\(Constant.createdTitle): \(day.created.convertDateFormater(inputFormat: Constant.inputDatedFormat, outputFormat: Constant.outputDatedFormat))",
						  conditionField: "\(Constant.stateTitle): \(day.weatherStateName)",
					   	maxTempField: "\(Constant.maxTemperatureTitle): \(Int(day.maxTemperature))°",
						minTempField: "\(Constant.minTemperatureTitle): \(Int(day.minTemperature))°",
			windSpeedField: "\(Constant.windDirectionTitle): \(day.windDirectionCompass)",
						weatherConditionImage: UIImage(named: day.weatherStateAbbr))
		
        return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if currentViewController == SelectedViewController.WeatherForecastByDays {
			self.day = locations[indexPath.row]
			performSegue(withIdentifier: hoursSegue, sender: location)
		}
	}
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if currentViewController == SelectedViewController.WeatherForecastByHours {
			return Constant.cellHeight
		} else {
			return 0
		}
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if currentViewController == SelectedViewController.WeatherForecastByHours {
			if let day = self.day {
				let vw = HeaderTableVIew()
				vw.day = day
				vw.location = location
				return vw
			}
			return nil
		} else {
			return nil
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == hoursSegue {
			if let segueDestination = segue.destination as? TemplateInfoTableViewController {
				let viewController:TemplateInfoTableViewController = segueDestination
				viewController.day = self.day
				viewController.location = sender as? Location
			}
		}
	}

}
