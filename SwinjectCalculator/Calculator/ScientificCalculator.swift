//
//  ScientificCalculator.swift
//  SwinjectCalculator
//
//  Created by Karthik M S on 15/09/19.
//  Copyright © 2019 MSK. All rights reserved.
//

import Foundation

class ScientificCalculator: Calculator {
	func add(_ n1: Float, to n2: Float) -> Float {
		return n1 + n2
	}

	func subtract(_ n1: Float, from n2: Float) -> Float {
		return n2 - n1
	}

	func multiply(_ n1: Float, and n2: Float) -> Float {
		return n1 * n2
	}

	func divide(_ n1: Float, by n2: Float) -> Float {
		return n1 / n2
	}
}
