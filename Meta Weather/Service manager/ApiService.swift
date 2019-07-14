//
//  ApiService.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 12.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit

class ApiService: NSObject {
	
	public enum FetchError: Error {
		case apiError
		case invalidEndpoint
		case invalidResponse
		case noData
		case serializationError
	}
	
	private let jsonDecoder: JSONDecoder = {
		let jsonDecoder = JSONDecoder()
		return jsonDecoder
	}()
	
	public static let shared = ApiService()
	private let urlSession = URLSession.shared
	
	public func fetchWeatherForecastDays(woeid: Int, successHandler: @escaping (_ response: Location) -> Void,
							errorHandler: @escaping(_ error: Error) -> Void) {
		
		guard let url = URL(string: "https://www.metaweather.com/api/location/\(woeid)/") else {
			handleError(errorHandler: errorHandler, error: FetchError.invalidEndpoint)
			return
		}
		
		
		urlSession.dataTask(with: url) { (data, response, error) in
			if error != nil {
				self.handleError(errorHandler: errorHandler, error: FetchError.apiError)
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
				self.handleError(errorHandler: errorHandler, error: FetchError.invalidResponse)
				return
			}
			
			guard let data = data else {
				self.handleError(errorHandler: errorHandler, error: FetchError.noData)
				return
			}
			
			do {
				let days = try self.jsonDecoder.decode(Location.self, from: data)
				DispatchQueue.main.async {
					successHandler(days)
				}
			} catch {
				self.handleError(errorHandler: errorHandler, error: FetchError.serializationError)
			}
			}.resume()
		
	}
	
	public func fetchWeatherForecastByHour(woeid: Int, date: String, successHandler: @escaping (_ response: [Day]) -> Void,
										 errorHandler: @escaping(_ error: Error) -> Void) {
		
		guard let url = URL(string: "https://www.metaweather.com/api/location/\(woeid)/\(date)/") else {
			handleError(errorHandler: errorHandler, error: FetchError.invalidEndpoint)
			return
		}
		
		
		urlSession.dataTask(with: url) { (data, response, error) in
			let responseData = String(data: data!, encoding: String.Encoding.utf8)
			if error != nil {
				self.handleError(errorHandler: errorHandler, error: FetchError.apiError)
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
				self.handleError(errorHandler: errorHandler, error: FetchError.invalidResponse)
				return
			}
			
			guard let data = data else {
				self.handleError(errorHandler: errorHandler, error: FetchError.noData)
				return
			}
			
			do {
				
				let days = try self.jsonDecoder.decode([Day].self, from: data)
				DispatchQueue.main.async {
					successHandler(days)
				}
			} catch {
				self.handleError(errorHandler: errorHandler, error: FetchError.serializationError)
			}
			}.resume()
		
	}
	
	private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
		DispatchQueue.main.async {
			errorHandler(error)
		}
	}
}
