//
//  CalculatorViewModelInput.swift
//  SwinjectCalculator
//
//  Created by Karthik M S on 15/09/19.
//  Copyright © 2019 MSK. All rights reserved.
//

import Foundation

enum CalculatorViewModelInput {
	// Numbers
	case zeroPressed
	case onePressed
	case twoPressed
	case threePressed
	case fourPressed
	case fivePressed
	case sixPressed
	case sevenPressed
	case eightPressed
	case ninePressed

	// Operations
	case addButtonPressed
	case subtractButtonPressed
	case multiplyButtonPressed
	case divideButtonPressed

	case clear
	case compute
}
