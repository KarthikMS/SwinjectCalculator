//
//  AppDelegate.swift
//  SwinjectCalculator
//
//  Created by Karthik M S on 15/09/19.
//  Copyright © 2019 MSK. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		let window = UIWindow(frame: UIScreen.main.bounds)
		window.backgroundColor = UIColor.white
		window.makeKeyAndVisible()
		self.window = window
		let storyboard = UIStoryboard(name: "Main", bundle: nil)

		guard let calculatorVC = storyboard.instantiateInitialViewController() as? CalculatorViewController else {
			assertionFailure()
			return false
		}
		let calculator = StandardCalculator()
		let logger = ConsoleLogger()
		let calculatorVM = CalculatorViewModel(calculator: calculator, logger: logger)
		let calculatorVCPresenter = CalculatorViewControllerPresenter(viewModelOutputs: calculatorVM.outputs)
		calculatorVC.presenter = calculatorVCPresenter
		calculatorVC.viewModelInputProcessor = calculatorVM

		window.rootViewController = calculatorVC

		return true
	}
}

