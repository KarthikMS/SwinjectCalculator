//
//  CalculatorViewModelAssembler.swift
//  SwinjectCalculator
//
//  Created by Karthik M S on 15/09/19.
//  Copyright © 2019 MSK. All rights reserved.
//

import Swinject

class CalculatorViewModelAssembly: Assembly {
	private let internalContainer: Container = {
		let container = Container()
		container.register(Calculator.self, factory: { _ in StandardCalculator()})
		container.register(Logger.self, factory: { _ in ConsoleLogger() })
		return container
	}()

	func assemble(container: Container) {
		let internalContainer = self.internalContainer
		container.register(CalculatorViewModel.self, factory: { r in
			CalculatorViewModel(
				calculator: internalContainer.resolve(Calculator.self)!,
				logger: internalContainer.resolve(Logger.self)!
			)
		})
	}
}

class CalculatorViewModelFactory {
	private static let calculatorViewModelAssembler = Assembler([CalculatorViewModelAssembly()])

	static func getViewModel() -> CalculatorViewModel {
		return calculatorViewModelAssembler.resolver.resolve(CalculatorViewModel.self)!
	}
}
