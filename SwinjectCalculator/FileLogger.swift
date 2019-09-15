//
//  FileLogger.swift
//  SwinjectCalculator
//
//  Created by Karthik M S on 15/09/19.
//  Copyright © 2019 MSK. All rights reserved.
//

import Foundation

class FileLogger: Logger {
	func log(_ message: String) {
		print("FileLogger: \(message)")
	}
}
