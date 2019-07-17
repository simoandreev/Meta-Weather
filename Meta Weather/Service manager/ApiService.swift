//
//  ApiService.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 12.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit

class ApiService: NSObject {
	
	private let baseUrl = "https://www.metaweather.com/api/location/"
	private let jsonDecoder: JSONDecoder = {
		let jsonDecoder = JSONDecoder()
		return jsonDecoder
	}()
	
	public static let shared = ApiService()
	private let urlSession = URLSession.shared
	
	public func fetchWeatherForecastDays(woeid: Int, completion: @escaping (Location?, Error?) -> Void) {
		let urlString = "\(baseUrl)\(woeid)/"
		fetchGenericJSONData(urlString: urlString, completion: completion)
	}
	
	public func fetchWeatherForecastByHour(woeid: Int, date: String, completion: @escaping ([Day]?, Error?) -> Void) {
		let urlString = "\(baseUrl)\(woeid)/\(date)/"
		fetchGenericJSONData(urlString: urlString, completion: completion)
	}
	
	public func searchingForExistingCityWeatherForecast(name: String, completion: @escaping ([Location]?, Error?) -> Void) {
		let urlString = "\(baseUrl)search/?query=\(name)"
		fetchGenericJSONData(urlString: urlString, completion: completion)
	}
	
	private func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
		guard let url = URL(string: urlString) else { return }
		URLSession.shared.dataTask(with: url) { (data, resp, err) in
			if let err = err {
				completion(nil, err)
				return
			}
			do {
				guard let data = data else { return }
				let objects = try JSONDecoder().decode(T.self, from: data)
				// success
				completion(objects, nil)
			} catch {
				completion(nil, error)
			}
			}.resume()
	}
}
