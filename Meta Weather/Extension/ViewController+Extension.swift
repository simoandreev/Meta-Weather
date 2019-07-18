//
//  ViewController+Extension.swift
//  Meta Weather
//
//  Created by Simeon Andreev on 18.07.19.
//  Copyright © 2019 Simeon Andreev. All rights reserved.
//

import UIKit

var vSpinner : UIView?

extension UIViewController {
	func showSpinner(onView : UIView) {
		let spinnerView = UIView.init(frame: onView.bounds)
		spinnerView.backgroundColor = .clear
		let ai = UIActivityIndicatorView.init(style: .whiteLarge)
		ai.startAnimating()
		ai.center = spinnerView.center
		
		DispatchQueue.main.async {
			spinnerView.addSubview(ai)
			onView.addSubview(spinnerView)
		}
		
		vSpinner = spinnerView
	}
	
	func removeSpinner() {
		DispatchQueue.main.async {
			vSpinner?.removeFromSuperview()
			vSpinner = nil
		}
	}
	
	func hideKeyboardWhenTappedAround() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}
