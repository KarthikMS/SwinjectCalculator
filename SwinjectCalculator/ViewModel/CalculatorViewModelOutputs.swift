//
//  CalculatorViewModelOutputs.swift
//  SwinjectCalculator
//
//  Created by Karthik M S on 15/09/19.
//  Copyright © 2019 MSK. All rights reserved.
//

import RxSwift

struct CalculatorViewModelOutputs {
	let labelStringStream = BehaviorSubject<String>(value: "0")
	let isOperatorEnabledStream = BehaviorSubject<Bool>(value: false)
	let equalToButtonIsEnabledStream = BehaviorSubject<Bool>(value: false)
	let areNumbersEnabledStream = BehaviorSubject<Bool>(value: true)
}
