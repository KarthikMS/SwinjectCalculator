//
//  CalculatorViewModel.swift
//  SwinjectCalculator
//
//  Created by Karthik M S on 15/09/19.
//  Copyright © 2019 MSK. All rights reserved.
//

import RxSwift

class CalculatorViewModel {
	// MARK: - Dependencies
	private let calculator: Calculator
	private let logger: Logger

	// MARK: - Properties
	let outputs = CalculatorViewModelOutputs()

	var n1: Float?
	var n2: Float?
	var mathematicalOp: MathematicalOperation?
	var isMathematicalOpSet = false

	// MARK: - Initializers
	init(calculator: Calculator, logger: Logger) {
		self.calculator = calculator
		self.logger = logger
	}
}

// MARK: - CalculatorViewModeInputProcessor
extension CalculatorViewModel: CalculatorViewModeInputProcessor {
	func process(_ input: CalculatorViewModelInput) {
		switch input {
		case .zeroPressed:
			setNumber(digit: 0)

		case .onePressed:
			setNumber(digit: 1)
		case .twoPressed:
			setNumber(digit: 2)
		case .threePressed:
			setNumber(digit: 3)

		case .fourPressed:
			setNumber(digit: 4)
		case .fivePressed:
			setNumber(digit: 5)
		case .sixPressed:
			setNumber(digit: 6)

		case .sevenPressed:
			setNumber(digit: 7)
		case .eightPressed:
			setNumber(digit: 8)
		case .ninePressed:
			setNumber(digit: 9)

		case .addButtonPressed:
			setMathematicalOp(.addition)
		case .subtractButtonPressed:
			setMathematicalOp(.subtraction)
		case .multiplyButtonPressed:
			setMathematicalOp(.multiplication)
		case .divideButtonPressed:
			setMathematicalOp(.division)

		case .compute:
			computeMathematicalOperation()
		case .clear:
			clear()
		}
	}
}

// MARK: - Util
private extension CalculatorViewModel {
	func setNumber(digit: Int) {
		if isMathematicalOpSet {
			setN2(digit: digit)
		} else {
			setN1(digit: digit)
		}
	}

	func setN1(digit: Int) {
		var n = ""
		if let n1 = n1 {
			n = String(Int(n1))
		}
		n = n + "\(digit)"
		n1 = Float(n)

		// Output generation
		outputs.labelStringStream.onNext(labelText)
		outputs.isOperatorEnabledStream.onNext(true)
	}

	func setN2(digit: Int) {
		var n = ""
		if let n2 = n2 {
			n = String(Int(n2))
		}
		n = n + "\(digit)"
		n2 = Float(n)

		// Output generation
		outputs.labelStringStream.onNext(labelText)
		outputs.equalToButtonIsEnabledStream.onNext(true)
	}

	func setMathematicalOp(_ op: MathematicalOperation) {
		mathematicalOp = op
		isMathematicalOpSet = true

		// Output generation
		outputs.labelStringStream.onNext(labelText)
		outputs.isOperatorEnabledStream.onNext(false)
	}

	func computeMathematicalOperation() {
		guard let n1 = n1,
			let n2 = n2,
			let mathematicalOp = mathematicalOp else {
				assertionFailure()
				return
		}

		let result: Float
		switch mathematicalOp {
		case .addition:
			result = calculator.add(n1, to: n2)
		case .subtraction:
			result = calculator.subtract(n2, from: n1)
		case .multiplication:
			result = calculator.multiply(n1, and: n2)
		case .division:
			result = calculator.divide(n1, by: n2)
		}

		// Output generation
		let resultString = String(result)
		outputs.labelStringStream.onNext(resultString)
		outputs.equalToButtonIsEnabledStream.onNext(false)
		outputs.areNumbersEnabledStream.onNext(false)

		// Logging
		let logMessage = labelText + " = " + resultString
		logger.log(logMessage)
	}

	func clear() {
		n1 = nil
		n2 = nil
		mathematicalOp = nil
		isMathematicalOpSet = false

		// Output generation
		outputs.labelStringStream.onNext("0")
		outputs.isOperatorEnabledStream.onNext(false)
		outputs.equalToButtonIsEnabledStream.onNext(false)
		outputs.areNumbersEnabledStream.onNext(true)
	}

	var labelText: String {
		var labelText = "0"

		if let n1 = n1 {
			labelText = "\(n1)"
		}

		if let op = mathematicalOp {
			switch op {
			case .addition:
				labelText += " + "
			case .subtraction:
				labelText += " - "
			case .multiplication:
				labelText += " * "
			case .division:
				labelText += " / "
			}
		}

		if let n2 = n2 {
			labelText += "\(n2)"
		}

		return labelText
	}
}
