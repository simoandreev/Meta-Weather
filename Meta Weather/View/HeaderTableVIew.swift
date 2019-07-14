//
//  HeaderTableVIew.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 14.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit

class HeaderTableVIew: UIView {

	var day: Day? {
		didSet {
			setupView()
		}
	}

	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	lazy var headerTitle: UILabel = {
		let headerTitle = UILabel()
		headerTitle.translatesAutoresizingMaskIntoConstraints = false
		headerTitle.font = UIFont.systemFont(ofSize: 22, weight: .medium)
		headerTitle.text = "History"
		headerTitle.textAlignment = .left
		headerTitle.backgroundColor = .red
		return headerTitle
	}()
	lazy var minTemp: UILabel = {
		let minTemp = UILabel()
		minTemp.translatesAutoresizingMaskIntoConstraints = false
		minTemp.textAlignment = .left
		return minTemp
	}()
	lazy var maxTemp: UILabel = {
		let maxTemp = UILabel()
		maxTemp.translatesAutoresizingMaskIntoConstraints = false
		maxTemp.textAlignment = .left
		return maxTemp
	}()
	
	lazy var headerView: UIView = {
		let headerView = UIView()
		headerView.translatesAutoresizingMaskIntoConstraints = false
		headerView.backgroundColor = UIColor(red: 22/255, green: 160/255, blue: 133/255, alpha: 0.5)
		headerView.layer.shadowColor = UIColor.gray.cgColor
		headerView.layer.shadowOffset = CGSize(width: 0, height: 10)
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
		headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		headerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
		headerView.addSubview(headerTitle)
		headerView.addSubview(imageView)
		headerView.addSubview(minTemp)
		headerView.addSubview(maxTemp)
		
		headerTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		headerTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
		headerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		
		imageView.image = UIImage(named: day?.weather_state_abbr ?? "")
		imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
		imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
		
		if let text = self.day?.min_temp {
			minTemp.text = "Min temp: \(String(text))"
		}
		minTemp.widthAnchor.constraint(equalToConstant: 200).isActive = true
		minTemp.heightAnchor.constraint(equalToConstant: 25).isActive = true
		minTemp.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
		minTemp.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
		
		if let text = self.day?.max_temp {
			maxTemp.text = "Max temp: \(String(text))"
		}
		maxTemp.widthAnchor.constraint(equalToConstant: 200).isActive = true
		maxTemp.heightAnchor.constraint(equalToConstant: 25).isActive = true
		maxTemp.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16).isActive = true
		maxTemp.topAnchor.constraint(equalTo: minTemp.bottomAnchor).isActive = true
	
		
	}
}
