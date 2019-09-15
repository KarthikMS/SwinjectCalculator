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
			// Model
			container.register(Calculator.self, factory: { _ in StandardCalculator()})
			container.register(Logger.self, factory: { _ in ConsoleLogger() })

			// ViewModel
			container.register(CalculatorViewModel.self, factory: { r in
				CalculatorViewModel(
					calculator: r.resolve(Calculator.self)!,
					logger: r.resolve(Logger.self)!
				)
			})

			// Views
			// CalculatorViewModeInputProcessor
			container.register(CalculatorViewModeInputProcessor.self, factory: { r in
				r.resolve(CalculatorViewModel.self)!
			})
			// Presenter
			container.register(CalculatorViewControllerPresenter.self, factory: { r in
				CalculatorViewControllerPresenter(viewModelOutputs: r.resolve(CalculatorViewModel.self)!.outputs)
			})
			container.storyboardInitCompleted(UINavigationController.self) { _,_ in }
			container.storyboardInitCompleted(CalculatorViewController.self) { r, vc in
				vc.presenter = r.resolve(CalculatorViewControllerPresenter.self)!
				vc.viewModelInputProcessor = r.resolve(CalculatorViewModeInputProcessor.self)!
			}
		}
	}
}
