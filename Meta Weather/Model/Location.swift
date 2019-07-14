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
	let consolidated_weather: [Day]?
}

struct Day: Codable {
	let weather_state_name: String
	let weather_state_abbr: String
	let wind_direction_compass: String
	let created: String
	let applicable_date: String
	let min_temp: Float
	let max_temp: Float
	let the_temp: Float
	let wind_speed: Float
	let wind_direction: Float
	let air_pressure: Float
	let humidity: Int
	let visibility: Float?
	let predictability: Int
}
