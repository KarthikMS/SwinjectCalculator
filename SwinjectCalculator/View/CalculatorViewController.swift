//
//  CalculatorViewController.swift
//  SwinjectCalculator
//
//  Created by Karthik M S on 15/09/19.
//  Copyright © 2019 MSK. All rights reserved.
//

import RxCocoa
import RxSwift

class CalculatorViewController: UIViewController {
	// MARK: - IBOutlets
	@IBOutlet private weak var label: UILabel!

	// Numbers
	@IBOutlet private weak var button0: UIButton!
	@IBOutlet private weak var button1: UIButton!
	@IBOutlet private weak var button2: UIButton!
	@IBOutlet private weak var button3: UIButton!
	@IBOutlet private weak var button4: UIButton!
	@IBOutlet private weak var button5: UIButton!
	@IBOutlet private weak var button6: UIButton!
	@IBOutlet private weak var button7: UIButton!
	@IBOutlet private weak var button8: UIButton!
	@IBOutlet private weak var button9: UIButton!

	// Operators
	@IBOutlet private weak var additionButton: UIButton!
	@IBOutlet private weak var subtractionButton: UIButton!
	@IBOutlet private weak var multiplicationButton: UIButton!
	@IBOutlet private weak var divisionButton: UIButton!

	@IBOutlet private weak var equalToButton: UIButton!
	@IBOutlet private weak var clearButton: UIButton!

	// MARK: - Dependencies
	var presenter: CalculatorViewControllerPresenter!
	var viewModelInputProcessor: CalculatorViewModeInputProcessor!

	// MARK: - Util
	private let disposeBag = DisposeBag()
}

// MARK: - View Life Cycle
extension CalculatorViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		bindWithPresenter()
		bindInputsToViewModel()
	}
}

// MARK: - Setup
private extension CalculatorViewController {
	func bindWithPresenter() {
		presenter.labelDriver
			.drive(label.rx.text)
			.disposed(by: disposeBag)

		presenter.addButtonIsEnabledDriver
			.drive(additionButton.rx.isEnabled)
			.disposed(by: disposeBag)
		presenter.subButtonIsEnabledDriver
			.drive(subtractionButton.rx.isEnabled)
			.disposed(by: disposeBag)
		presenter.multiplyButtonIsEnabledDriver
			.drive(multiplicationButton.rx.isEnabled)
			.disposed(by: disposeBag)
		presenter.divideButtonIsEnabledDriver
			.drive(divisionButton.rx.isEnabled)
			.disposed(by: disposeBag)

		presenter.equalToButtonIsEnabledDriver
			.drive(equalToButton.rx.isEnabled)
			.disposed(by: disposeBag)

		presenter.numberButtonsAreEnabledDriver
			.drive(button0.rx.isEnabled)
			.disposed(by: disposeBag)

		presenter.numberButtonsAreEnabledDriver
			.drive(button1.rx.isEnabled)
			.disposed(by: disposeBag)
		presenter.numberButtonsAreEnabledDriver
			.drive(button2.rx.isEnabled)
			.disposed(by: disposeBag)
		presenter.numberButtonsAreEnabledDriver
			.drive(button3.rx.isEnabled)
			.disposed(by: disposeBag)

		presenter.numberButtonsAreEnabledDriver
			.drive(button4.rx.isEnabled)
			.disposed(by: disposeBag)
		presenter.numberButtonsAreEnabledDriver
			.drive(button5.rx.isEnabled)
			.disposed(by: disposeBag)
		presenter.numberButtonsAreEnabledDriver
			.drive(button6.rx.isEnabled)
			.disposed(by: disposeBag)

		presenter.numberButtonsAreEnabledDriver
			.drive(button7.rx.isEnabled)
			.disposed(by: disposeBag)
		presenter.numberButtonsAreEnabledDriver
			.drive(button8.rx.isEnabled)
			.disposed(by: disposeBag)
		presenter.numberButtonsAreEnabledDriver
			.drive(button9.rx.isEnabled)
			.disposed(by: disposeBag)
	}

	func bindInputsToViewModel() {
		// Numbers
		button0.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.zeroPressed)
			})
			.disposed(by: disposeBag)

		button1.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.onePressed)
			})
			.disposed(by: disposeBag)
		button2.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.twoPressed)
			})
			.disposed(by: disposeBag)
		button3.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.threePressed)
			})
			.disposed(by: disposeBag)

		button4.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.fourPressed)
			})
			.disposed(by: disposeBag)
		button5.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.fivePressed)
			})
			.disposed(by: disposeBag)
		button6.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.sixPressed)
			})
			.disposed(by: disposeBag)

		button7.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.sevenPressed)
			})
			.disposed(by: disposeBag)
		button8.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.eightPressed)
			})
			.disposed(by: disposeBag)
		button9.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.ninePressed)
			})
			.disposed(by: disposeBag)

		// Operators
		additionButton.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.addButtonPressed)
			})
			.disposed(by: disposeBag)
		subtractionButton.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.subtractButtonPressed)
			})
			.disposed(by: disposeBag)
		multiplicationButton.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.multiplyButtonPressed)
			})
			.disposed(by: disposeBag)
		divisionButton.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.divideButtonPressed)
			})
			.disposed(by: disposeBag)

		equalToButton.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.compute)
			})
			.disposed(by: disposeBag)
		clearButton.rx.tap
			.subscribe(onNext: { [unowned self] in
				self.viewModelInputProcessor.process(.clear)
			})
			.disposed(by: disposeBag)
	}
}
