//
//  CalculatorViewControllerPresenter.swift
//  SwinjectCalculator
//
//  Created by Karthik M S on 15/09/19.
//  Copyright © 2019 MSK. All rights reserved.
//

import RxCocoa

class CalculatorViewControllerPresenter {
	// MARK: - Properties
	let labelDriver: Driver<String>

	let addButtonIsEnabledDriver: Driver<Bool>
	let subButtonIsEnabledDriver: Driver<Bool>
	let multiplyButtonIsEnabledDriver: Driver<Bool>
	let divideButtonIsEnabledDriver: Driver<Bool>

	let equalToButtonIsEnabledDriver: Driver<Bool>
	let numberButtonsAreEnabledDriver: Driver<Bool>

	// MARK: - Initializers
	init(viewModelOutputs: CalculatorViewModelOutputs) {
		self.labelDriver = viewModelOutputs.labelStringStream
			.asDriver(onErrorJustReturn: "0")
		
		self.equalToButtonIsEnabledDriver = viewModelOutputs.equalToButtonIsEnabledStream
			.distinctUntilChanged()
			.asDriver(onErrorJustReturn: false)
		
		self.addButtonIsEnabledDriver = viewModelOutputs.isOperatorEnabledStream
			.distinctUntilChanged()
			.asDriver(onErrorJustReturn: false)
		
		self.subButtonIsEnabledDriver = viewModelOutputs.isOperatorEnabledStream
			.distinctUntilChanged()
			.asDriver(onErrorJustReturn: false)
		
		self.multiplyButtonIsEnabledDriver = viewModelOutputs.isOperatorEnabledStream
			.distinctUntilChanged()
			.asDriver(onErrorJustReturn: false)
		
		self.divideButtonIsEnabledDriver = viewModelOutputs.isOperatorEnabledStream
			.distinctUntilChanged()
			.asDriver(onErrorJustReturn: false)

		self.numberButtonsAreEnabledDriver = viewModelOutputs.areNumbersEnabledStream
			.distinctUntilChanged()
			.asDriver(onErrorJustReturn: false)
	}
}
