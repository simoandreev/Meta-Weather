//
//  HeaderTableVIew.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 14.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit

class HeaderTableVIew: UIView {
	
	private enum Constant {
		static let cellHeight: CGFloat = 260
		static let imageSize: CGFloat = 40
		static let spacing: CGFloat = 8
		static let bigSpacing: CGFloat = 16
		static let largeFontSize: CGFloat = 28
		static let tableViewHeaderFontSize: CGFloat = 18
		static let shadowOffsetSize = CGSize(width: 0, height: 5)
		static let shadowOpacity: Float = 1
		static let shadowRadius: CGFloat = 5
		
		static let tableViewHeaderTitle = "History"
		static let weatherStateTitle = "State"
		static let windDirectionTitle = "Wind direction"
		static let windSpeedTitle = "Wind speed"
		static let maxTemperatureTitle = "Max"
		static let minTemperatureTitle = "Min"
		static let airPresureTitle = "Air Presure"
		static let humidityTitle = "Humidity"
		static let visibilityTitle = "Visibility"
		
		static let tableViewHeaderColor = UIColor(red: 92/255, green: 140/255, blue: 206/255, alpha: 1.0)
	}
	
	var day: Day?
	var location: Location? {
		didSet {
			setupView()
		}
	}
	private lazy var stackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis  = NSLayoutConstraint.Axis.horizontal
		stackView.distribution  = UIStackView.Distribution.equalSpacing
		stackView.alignment = UIStackView.Alignment.center
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = Constant.bigSpacing
		return stackView
	}()
	
	private lazy var leftStackView: UIStackView = {
		let leftStackView = UIStackView()
		leftStackView.axis  = NSLayoutConstraint.Axis.vertical
		leftStackView.distribution  = UIStackView.Distribution.equalSpacing
		leftStackView.alignment = UIStackView.Alignment.leading
		leftStackView.translatesAutoresizingMaskIntoConstraints = false
		leftStackView.spacing = Constant.spacing
		return leftStackView
	}()
	
	private lazy var rightStackView: UIStackView = {
		let rightStackView = UIStackView()
		rightStackView.axis  = NSLayoutConstraint.Axis.vertical
		rightStackView.distribution  = UIStackView.Distribution.equalSpacing
		rightStackView.alignment = UIStackView.Alignment.trailing
		rightStackView.translatesAutoresizingMaskIntoConstraints = false
		rightStackView.spacing = Constant.spacing
		return rightStackView
	}()

	private lazy var locationTitle: UILabel = {
		let locationTitle = UILabel()
		locationTitle.translatesAutoresizingMaskIntoConstraints = false
		locationTitle.font = UIFont.systemFont(ofSize: Constant.largeFontSize, weight: .medium)
		locationTitle.textAlignment = .center
		return locationTitle
	}()
	private lazy var currentTemperature: UILabel = {
		let currentTemperature = UILabel()
		currentTemperature.translatesAutoresizingMaskIntoConstraints = false
		currentTemperature.font = UIFont.systemFont(ofSize: Constant.largeFontSize, weight: .medium)
		currentTemperature.textAlignment = .center
		return currentTemperature
	}()
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private lazy var headerTitle: UILabel = {
		let headerTitle = UILabel()
		headerTitle.translatesAutoresizingMaskIntoConstraints = false
		headerTitle.font = UIFont.systemFont(ofSize: Constant.tableViewHeaderFontSize, weight: .medium)
		headerTitle.text = Constant.tableViewHeaderTitle
		headerTitle.textAlignment = .center
		headerTitle.backgroundColor = UIColor.gray
		return headerTitle
	}()
	private lazy var stateName: UILabel = {
		let stateName = UILabel()
		stateName.translatesAutoresizingMaskIntoConstraints = false
		stateName.textAlignment = .left
		return stateName
	}()
	private lazy var windDirection: UILabel = {
		let windDirection = UILabel()
		windDirection.translatesAutoresizingMaskIntoConstraints = false
		windDirection.textAlignment = .left
		return windDirection
	}()
	private lazy var windSpeed: UILabel = {
		let windSpeed = UILabel()
		windSpeed.translatesAutoresizingMaskIntoConstraints = false
		windSpeed.textAlignment = .left
		return windSpeed
	}()
	private lazy var minTemp: UILabel = {
		let minTemp = UILabel()
		minTemp.translatesAutoresizingMaskIntoConstraints = false
		minTemp.textAlignment = .left
		return minTemp
	}()
	private lazy var maxTemp: UILabel = {
		let maxTemp = UILabel()
		maxTemp.translatesAutoresizingMaskIntoConstraints = false
		maxTemp.textAlignment = .left
		return maxTemp
	}()
	private lazy var airPresure: UILabel = {
		let airPresure = UILabel()
		airPresure.translatesAutoresizingMaskIntoConstraints = false
		airPresure.textAlignment = .right
		return airPresure
	}()
	private lazy var humidity: UILabel = {
		let humidity = UILabel()
		humidity.translatesAutoresizingMaskIntoConstraints = false
		humidity.textAlignment = .right
		return humidity
	}()
	private lazy var visibility: UILabel = {
		let visibility = UILabel()
		visibility.translatesAutoresizingMaskIntoConstraints = false
		visibility.textAlignment = .right
		return visibility
	}()
	
	private lazy var headerView: UIView = {
		let headerView = UIView()
		headerView.translatesAutoresizingMaskIntoConstraints = false
		headerView.backgroundColor = Constant.tableViewHeaderColor
		headerView.layer.shadowColor = UIColor.gray.cgColor
		headerView.layer.shadowOffset = Constant.shadowOffsetSize
		headerView.layer.shadowOpacity = Constant.shadowOpacity
		headerView.layer.shadowRadius = Constant.shadowRadius
		return headerView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	private func setupView() {
		addSubview(headerView)
		headerView.addSubview(locationTitle)
		headerView.addSubview(stackView)
		headerView.addSubview(rightStackView)
		headerView.addSubview(leftStackView)
		headerView.addSubview(headerTitle)
		stackView.addArrangedSubview(currentTemperature)
		stackView.addArrangedSubview(imageView)
		leftStackView.addArrangedSubview(stateName)
		leftStackView.addArrangedSubview(windDirection)
		leftStackView.addArrangedSubview(windSpeed)
		leftStackView.addArrangedSubview(minTemp)
		leftStackView.addArrangedSubview(maxTemp)
		rightStackView.addArrangedSubview(airPresure)
		rightStackView.addArrangedSubview(humidity)
		rightStackView.addArrangedSubview(visibility)
		
		headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		headerView.heightAnchor.constraint(equalToConstant: Constant.cellHeight).isActive = true
		
		locationTitle.text = location?.title
		locationTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		locationTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: Constant.spacing).isActive = true

		headerTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		headerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		
		if let temp = day?.currenTemperature {
			currentTemperature.text = "\(String(Int(temp)))°"
		}
		
		imageView.image = UIImage(named: day?.weatherStateAbbr ?? "")
		imageView.widthAnchor.constraint(equalToConstant: Constant.imageSize).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: Constant.imageSize).isActive = true
		
		stackView.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: Constant.spacing).isActive = true
		stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		
		rightStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constant.spacing).isActive = true
		rightStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constant.bigSpacing).isActive = true
		
		leftStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constant.spacing).isActive = true
		leftStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constant.bigSpacing).isActive = true

		//Right Stack View
		if let stateNameDescription = self.day?.weatherStateName {
			stateName.text = "\(Constant.weatherStateTitle): \(stateNameDescription)"
		}
		if let wind = self.day?.windDirectionCompass {
			windDirection.text = "\(Constant.windDirectionTitle): \(wind)"
		}
		if let windSpeedDescription = self.day?.windSpeed {
			windSpeed.text = "\(Constant.windSpeedTitle): \(Int(windSpeedDescription)) mph"
		}
		if let maxTemperature = self.day?.maxTemperature {
			maxTemp.text = "\(Constant.maxTemperatureTitle): \(String(Int(maxTemperature)))°"
		}
		if let minTemperature = self.day?.minTemperature {
			minTemp.text = "\(Constant.minTemperatureTitle): \(String(Int(minTemperature)))°"
		}
		
		//Left Stack View
		if let airPresureDescription = self.day?.airPressure {
			airPresure.text = "\(Constant.airPresureTitle): \(String(Int(airPresureDescription))) mb"
		}
		if let humidityDescription = self.day?.humidity {
			humidity.text = "\(Constant.humidityTitle): \(String(humidityDescription)) %"
		}
		if let visibilityDescription = self.day?.visibility {
			visibility.text = "\(Constant.visibilityTitle): \(String(Int(visibilityDescription))) miles"
		}
	}
}
