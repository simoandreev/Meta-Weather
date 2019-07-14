//
//  DefaultTableViewCell.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 14.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {

	@IBOutlet private weak var dateField: UILabel!
	@IBOutlet private weak var conditionField: UILabel!
	@IBOutlet private weak var maxTempField: UILabel!
	@IBOutlet private weak var minTempField: UILabel!
	@IBOutlet private weak var windSpeedField: UILabel!
	@IBOutlet private weak var weatherConditionImageView: UIImageView!
	
	func configure(dateField: String?,
				   conditionField: String?,
				   maxTempField: String?,
				   minTempField: String?,
				   windSpeedField: String?) {
		
		self.dateField.text = dateField
		self.conditionField.text = conditionField
		self.maxTempField.text = maxTempField
		self.minTempField.text = minTempField
		self.windSpeedField.text = windSpeedField
	}
    
}
