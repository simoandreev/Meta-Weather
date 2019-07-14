//
//  WeekDaysInfoTableViewController.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 13.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit

class TemplateInfoTableViewController: UITableViewController {
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
		tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
	
	private func fetchData() {
		if currentViewController == SelectedViewController.WeatherForecastByDays {
			ApiService.shared.fetchWeatherForecastDays(woeid: location?.woeid ?? 0) { (response, error) in
				if let error = error {
					print("Failed to fetch data:", error)
					print(error.localizedDescription)
					return
				}
				if let responseDays = response?.consolidated_weather { 
					self.locations = responseDays
					DispatchQueue.main.async {
						self.tableView.reloadData()
					}
				}
				
			}
		} else {
			ApiService.shared.fetchWeatherForecastByHour(woeid: location?.woeid ?? 0, date: convertDateFormater(self.day?.applicable_date ?? "")) { (response, error) in
				if let error = error {
					print("Failed to fetch data:", error)
					print(error.localizedDescription)
					return
				}
				if let responseHours = response{
					self.locations = responseHours
					DispatchQueue.main.async {
						self.tableView.reloadData()
					}
				}
			}
		}
	}
	func convertDateFormater(_ date: String) -> String
	{
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let date = dateFormatter.date(from: date)
		dateFormatter.dateFormat = "yyyy/MM/dd"
		return  dateFormatter.string(from: date!)
		
	}
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DefaultTableViewCell
		let day = locations[indexPath.row]
		cell.configure(dateField: currentViewController == SelectedViewController.WeatherForecastByDays ? day.applicable_date : day.created, conditionField: day.weather_state_name, maxTempField: String(day.max_temp), minTempField: String(day.min_temp), windSpeedField: day.wind_direction_compass, weatherConditionImage: UIImage(named: day.weather_state_abbr))
		
        return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if currentViewController == SelectedViewController.WeatherForecastByDays {
			
//			if let selectedLocation = self.locations[indexPath.row] {
//				day = selectedLocation
//			}
			self.day = locations[indexPath.row]
			//print(locations[indexPath.row])
			performSegue(withIdentifier: hoursSegue, sender: location)
			
		}
	}
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if currentViewController == SelectedViewController.WeatherForecastByHours {
			return 150
		} else {
			return 0
		}
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if currentViewController == SelectedViewController.WeatherForecastByHours {
			let vw = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150))
			vw.backgroundColor = UIColor.purple
	
			return vw
		} else {
			return nil
		}
	}
//	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//		let vw = UIView()
//		vw.backgroundColor = UIColor.red
//
//		return vw
//	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == hoursSegue {
			let viewController:TemplateInfoTableViewController = segue.destination as! TemplateInfoTableViewController
			viewController.day = self.day
			viewController.location = sender as? Location
			
		}
	}

}
