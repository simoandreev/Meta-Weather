//
//  PersistantManager.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 13.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit
import CoreData

class PersistantManager {
	private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	func save(location: Location) {
		let newItem = LocationCD(context: context)
		newItem.woeid = Int64(location.woeid)
		newItem.title = location.title
	
		saveContext()
	}
	
	func convertToLocation(locationCD: LocationCD) -> Location {
		let location = Location(title: locationCD.title ?? "", woeid: Int(locationCD.woeid), consolidatedWeather: [])
		return location
	}

	func loadLocations() -> [LocationCD] {
		let request: NSFetchRequest<LocationCD> = LocationCD.fetchRequest()
		var locations: [LocationCD] = []
		do {
			locations = try context.fetch(request)
		} catch {
			print("Error fetching data from context \(error)")
		}
		return locations
	}
	
	func someEntityExists(woeid: Int) -> Bool {
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LocationCD")
		fetchRequest.predicate = NSPredicate(format: "woeid = %d", woeid)
		
		var results: [NSManagedObject] = []
		
		do {
			results = try context.fetch(fetchRequest)
		}
		catch {
			print("error executing fetch request: \(error)")
		}
		
		return results.count > 0
	}

	func deleteItem(object: LocationCD) {
		context.delete(object)
		saveContext()
	}
	
	private func saveContext() {
		do {
			try context.save()
		} catch {
			print("Error saving context \(error)")
		}
	}
}
