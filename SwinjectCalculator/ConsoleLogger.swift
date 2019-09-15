//
//  ConsoleLogger.swift
//  SwinjectCalculator
//
//  Created by Karthik M S on 15/09/19.
//  Copyright © 2019 MSK. All rights reserved.
//

import Foundation

class ConsoleLogger: Logger {
	func log(_ message: String) {
		print("ConsoleLogger: \(message)")
	}
}
