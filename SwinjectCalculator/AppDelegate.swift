//
//  AppDelegate.swift
//  SwinjectCalculator
//
//  Created by Karthik M S on 15/09/19.
//  Copyright © 2019 MSK. All rights reserved.
//

import UIKit
import CoreData
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	var container: Container!

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		setUpWindow()
		injectDependencies(usingSwinject: true)
		return true
	}
}

// MARK: - Util
private extension AppDelegate {
	func setUpWindow() {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.backgroundColor = UIColor.white
		window.makeKeyAndVisible()
		self.window = window
	}

	func injectDependencies(usingSwinject: Bool) {
		if usingSwinject {
			injectDependenciesUsingSwinject()
		} else {
			injectDependenciesWithoutUsingSwinject()
		}
	}

	func injectDependenciesWithoutUsingSwinject() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		guard let calculatorVC = storyboard.instantiateInitialViewController() as? CalculatorViewController else {
			assertionFailure()
			return
		}
		let calculator = StandardCalculator()
		let logger = ConsoleLogger()
		let calculatorVM = CalculatorViewModel(calculator: calculator, logger: logger)
		let calculatorVCPresenter = CalculatorViewControllerPresenter(viewModelOutputs: calculatorVM.outputs)
		calculatorVC.presenter = calculatorVCPresenter
		calculatorVC.viewModelInputProcessor = calculatorVM

		window?.rootViewController = calculatorVC
	}

	func injectDependenciesUsingSwinject() {
		container = swinjectContainer
		let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
		window?.rootViewController = storyboard.instantiateInitialViewController()
	}

	var swinjectContainer: Container {
		return Container() { container in
			let calculatorViewModel = CalculatorViewModelFactory.getViewModel()
			container.register(CalculatorViewModeInputProcessor.self, factory: { _ in
				calculatorViewModel
			})
			container.register(CalculatorViewControllerPresenter.self, factory: { _ in
				CalculatorViewControllerPresenter(viewModelOutputs: calculatorViewModel.outputs)
			})
			container.storyboardInitCompleted(UINavigationController.self) { _,_ in }
			container.storyboardInitCompleted(CalculatorViewController.self) { r, vc in
				vc.presenter = r.resolve(CalculatorViewControllerPresenter.self)!
				vc.viewModelInputProcessor = r.resolve(CalculatorViewModeInputProcessor.self)!
			}
		}
	}
}
