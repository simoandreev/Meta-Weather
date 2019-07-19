//
//  ViewController.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 12.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit
import CoreData
import Reachability
import NotificationBannerSwift

class HomeTableViewController: UITableViewController {
	private enum Constant {
		static let connectionStatusTitle = "Connection status: "
		static let connectionStatusOnineTitle = "Online"
		static let connectionStatusOfflineTitle = "Offline"
		static let errorTitle = "Error"
		static let cantDeleteDefaultLocationMessage = "Can't delete the default location."
		static let devTargetSelectedMessage = "Dev Target selected"
		static let uaTargetSelectedMessage = "Ua Target selected"
		static let productionTargetSelectedMessage = "Production Target selected"
		static let testTargetSelectedMessage = "Test Target selected"
		
		static let tableViewBackgroundColor = UIColor(red: 92/255, green: 140/255, blue: 206/255, alpha: 1.0)
	}
	private var locationsCD: [LocationCD]?
	private let cellId = "homeCell"
	private let weekDaysSegue = "showWeekDaysInfo"
	private let persistanceManager: PersistantManager = PersistantManager()
	private let reachability = Reachability()
	private let defaultCityArray = [Location(title: "Sofia", woeid: 839722, consolidatedWeather: []),
							Location(title: "New York", woeid: 2459115, consolidatedWeather: []),
							Location(title: "Tokyo", woeid: 1118370, consolidatedWeather: [])]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		checkTargetSelection()
		
		tableView.tableFooterView = UIView()
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.tableView.backgroundColor = Constant.tableViewBackgroundColor
		
		checkReachability()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		for location in defaultCityArray {
			if !persistanceManager.someEntityExists(woeid: location.woeid) {
				persistanceManager.save(location: location)
			}
		}
		locationsCD = persistanceManager.loadLocations()
		self.tableView.reloadData()
	}
	
	private func checkTargetSelection() {
		#if Dev
			let banner = StatusBarNotificationBanner(title: Constant.devTargetSelectedMessage, style: .info)
			banner.show()
		#elseif Test
			let banner = StatusBarNotificationBanner(title: Constant.testTargetSelectedMessage, style: .info)
			banner.show()
		#elseif Ua
			let banner = StatusBarNotificationBanner(title: Constant.uaTargetSelectedMessage, style: .info)
			banner.show()
		#else
			let banner = StatusBarNotificationBanner(title: Constant.productionTargetSelectedMessage, style: .info)
			banner.show()
		#endif
	}
	
	private func checkReachability() {
		do {
			try reachability?.startNotifier()
		} catch {
			return
		}
		reachability?.whenReachable = { reachability in
			let banner = NotificationBanner(title: Constant.connectionStatusTitle, subtitle: Constant.connectionStatusOnineTitle, style: .success)
			banner.show()
		}
		reachability?.whenUnreachable = { reachability in
			let banner = NotificationBanner(title: Constant.connectionStatusTitle, subtitle: Constant.connectionStatusOfflineTitle, style: .danger)
			banner.show()
		}
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
					let banner = NotificationBanner(title: Constant.errorTitle, subtitle: Constant.cantDeleteDefaultLocationMessage, style: .warning)
					banner.show()
				} else {
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

