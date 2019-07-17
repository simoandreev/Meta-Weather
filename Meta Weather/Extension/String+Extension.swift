//
//  String+Extension.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 15.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import Foundation

extension String {
	func convertDateFormater(inputFormat: String = "yyyy-MM-dd", outputFormat: String = "yyyy/MM/dd") -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = inputFormat
		let date = dateFormatter.date(from: self)
		dateFormatter.dateFormat = outputFormat
		if let date = date {
			return  dateFormatter.string(from: date)
		}
		return ""
	}
}
