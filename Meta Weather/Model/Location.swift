//
//  CIty.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 13.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import Foundation

struct Location: Codable {
	let title: String
	let woeid: Int
	let consolidatedWeather: [Day]?
	
	enum CodingKeys: String, CodingKey {
		case title
		case woeid
		case consolidatedWeather = "consolidated_weather"
	}
}

struct Day: Codable {
	let weatherStateName: String
	let weatherStateAbbr: String
	let windDirectionCompass: String
	let created: String
	let applicableDate: String
	let minTemperature: Float
	let maxTemperature: Float
	let currenTemperature: Float
	let windSpeed: Float
	let windDirection: Float
	let airPressure: Float
	let humidity: Int
	let visibility: Float?
	let predictability: Int
	
	enum CodingKeys: String, CodingKey {
		case weatherStateName = "weather_state_name"
		case weatherStateAbbr = "weather_state_abbr"
		case windDirectionCompass = "wind_direction_compass"
		case created
		case applicableDate = "applicable_date"
		case minTemperature = "min_temp"
		case maxTemperature = "max_temp"
		case currenTemperature = "the_temp"
		case windSpeed = "wind_speed"
		case windDirection = "wind_direction"
		case airPressure = "air_pressure"
		case humidity
		case visibility
		case predictability
	}
}
