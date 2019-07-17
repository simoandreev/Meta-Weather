//
//  HeaderTableVIew.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 14.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit

class HeaderTableVIew: UIView {

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
		stackView.spacing = 16.0
		return stackView
	}()
	
	private lazy var leftStackView: UIStackView = {
		let leftStackView = UIStackView()
		leftStackView.axis  = NSLayoutConstraint.Axis.vertical
		leftStackView.distribution  = UIStackView.Distribution.equalSpacing
		leftStackView.alignment = UIStackView.Alignment.leading
		leftStackView.translatesAutoresizingMaskIntoConstraints = false
		leftStackView.spacing = 8.0
		return leftStackView
	}()
	
	private lazy var rightStackView: UIStackView = {
		let rightStackView = UIStackView()
		rightStackView.axis  = NSLayoutConstraint.Axis.vertical
		rightStackView.distribution  = UIStackView.Distribution.equalSpacing
		rightStackView.alignment = UIStackView.Alignment.trailing
		rightStackView.translatesAutoresizingMaskIntoConstraints = false
		rightStackView.spacing = 8.0
		return rightStackView
	}()

	private lazy var locationTitle: UILabel = {
		let locationTitle = UILabel()
		locationTitle.translatesAutoresizingMaskIntoConstraints = false
		locationTitle.font = UIFont.systemFont(ofSize: 28, weight: .medium)
		locationTitle.textAlignment = .center
		return locationTitle
	}()
	private lazy var currentTemperature: UILabel = {
		let currentTemperature = UILabel()
		currentTemperature.translatesAutoresizingMaskIntoConstraints = false
		currentTemperature.font = UIFont.systemFont(ofSize: 28, weight: .medium)
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
		headerTitle.font = UIFont.systemFont(ofSize: 18, weight: .medium)
		headerTitle.text = "History"
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
		headerView.backgroundColor = UIColor(red: 92/255, green: 140/255, blue: 206/255, alpha: 1.0)
		headerView.layer.shadowColor = UIColor.gray.cgColor
		headerView.layer.shadowOffset = CGSize(width: 0, height: 5)
		headerView.layer.shadowOpacity = 1
		headerView.layer.shadowRadius = 5
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
		headerView.heightAnchor.constraint(equalToConstant: 260).isActive = true
		
		locationTitle.text = location?.title
		locationTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		locationTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true

		headerTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		headerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		
		if let temp = day?.currenTemperature {
			currentTemperature.text = "\(String(Int(temp)))°"
		}
		
		imageView.image = UIImage(named: day?.weatherStateAbbr ?? "")
		imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
		
		stackView.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: 8).isActive = true
		stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		
		rightStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8).isActive = true
		rightStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
		
		leftStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8).isActive = true
		leftStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true

		//Right Stack View
		if let stateNameDescription = self.day?.weatherStateName {
			stateName.text = "State: \(stateNameDescription)"
		}
		if let wind = self.day?.windDirectionCompass {
			windDirection.text = "Wind direction: \(wind)"
		}
		if let windSpeedDescription = self.day?.windSpeed {
			windSpeed.text = "Wind speed: \(Int(windSpeedDescription)) mph"
		}
		if let maxTemperature = self.day?.maxTemperature {
			maxTemp.text = "Max: \(String(Int(maxTemperature)))°"
		}
		if let minTemperature = self.day?.minTemperature {
			minTemp.text = "Min: \(String(Int(minTemperature)))°"
		}
		
		//Left Stack View
		if let airPresureDescription = self.day?.airPressure {
			airPresure.text = "Air Presure: \(String(Int(airPresureDescription))) mb"
		}
		if let humidityDescription = self.day?.humidity {
			humidity.text = "Humidity: \(String(humidityDescription)) %"
		}
		if let visibilityDescription = self.day?.visibility {
			visibility.text = "Visibility: \(String(Int(visibilityDescription))) miles"
		}
	}
}
