import Foundation
import SwiftUI

final class MainViewModel: ObservableObject {
    // MARK: - Properties
    let rowNum: Int = 5
    let colNum: Int = 4
    
    private let numbersViewModel: NumbersViewModel = NumbersViewModel()
    private let buttonViewModels: [ButtonViewModel] = [
        ButtonViewModel(item: Item(key: .unaryOperation(UnaryOperationType.clear.rawValue))),
        ButtonViewModel(item: Item(key: .unaryOperation(UnaryOperationType.plusMinus.rawValue))),
        ButtonViewModel(item: Item(key: .unaryOperation(UnaryOperationType.percent.rawValue))),
        ButtonViewModel(item: Item(key: .operation(OperationType.division.rawValue))),
        ButtonViewModel(item: Item(key: .number(Number.seven.rawValue))),
        ButtonViewModel(item: Item(key: .number(Number.eight.rawValue))),
        ButtonViewModel(item: Item(key: .number(Number.nine.rawValue))),
        ButtonViewModel(item: Item(key: .operation(OperationType.multiplication.rawValue))),
        ButtonViewModel(item: Item(key: .number(Number.four.rawValue))),
        ButtonViewModel(item: Item(key: .number(Number.five.rawValue))),
        ButtonViewModel(item: Item(key: .number(Number.six.rawValue))),
        ButtonViewModel(item: Item(key: .operation(OperationType.substraction.rawValue))),
        ButtonViewModel(item: Item(key: .number(Number.one.rawValue))),
        ButtonViewModel(item: Item(key: .number(Number.two.rawValue))),
        ButtonViewModel(item: Item(key: .number(Number.three.rawValue))),
        ButtonViewModel(item: Item(key: .operation(OperationType.addition.rawValue))),
        ButtonViewModel(item: Item(key: .number(Number.zero.rawValue), widthRatio: 2)),
        ButtonViewModel(item: Item(key: .number(Number.comma.rawValue))),
        ButtonViewModel(item: Item(key: .operation(OperationType.equality.rawValue)))
    ]
    private var currentOperation: OperationType?
    private var firstOperand: Decimal?
    private var secondOperand: Decimal?
    private var currentNumber: Decimal {
        Validator.getNumberFromString(text: numbersViewModel.text)
    }
    private var isNewOperationSet: Bool = false
    private var isEqualityTapped: Bool = false
    
    // MARK: - Init
    init() {
        setDelegates()
    }
    
    // MARK: - Public Methods
    func getButtonsCount(atRow row: Int) -> Int {
        row == 4 ? colNum - 1 : colNum
    }
    
    func getButtonViewModel(row: Int, column: Int) -> ButtonViewModel {
        let index = row * colNum + column
        guard index < buttonViewModels.count else {
            return ButtonViewModel(item: Item(key: .operation(Number.zero.rawValue)))
        }
        
        return buttonViewModels[index]
    }
    
    func getNumbersViewModel() -> NumbersViewModel {
        numbersViewModel
    }
    
    // MARK: - Private Methods
    private func setDelegates() {
        buttonViewModels.forEach { buttonViewModel in
            buttonViewModel.delegate = self
        }
    }
    
    private func setOperationResult() {
        guard let firstOperand = firstOperand else {
            return
        }
        
        do {
            if secondOperand == nil {
                secondOperand = currentNumber
            }
            
            let result = try currentOperation?.calculate(first: firstOperand, second: secondOperand ?? 0) ?? 0
            numbersViewModel.text = Validator.validateCalcText(text: "\(result)")
            
            self.firstOperand = result
        } catch {
            numbersViewModel.text = "\(error.localizedDescription)"
        }
    }
    
    private func getNumberOfDigits(stringNumber: String) -> Int {
        if stringNumber.contains(",") {
            return stringNumber.count - 1
        }
        
        return stringNumber.count
    }
}

// MARK: - ButtonViewModelDelegate
extension MainViewModel: ButtonViewModelDelegate {
    func didTapNumber(number: Number) {
        if isNewOperationSet {
            isNewOperationSet = false
            numbersViewModel.text = ""
        }
        
        if number.rawValue == Number.comma.rawValue,
            numbersViewModel.text.contains(Number.comma.rawValue) {
            return
        }
        
        if numbersViewModel.text == "0", number.rawValue != Number.comma.rawValue {
            numbersViewModel.text = ""
        }
        
        numbersViewModel.text += number.rawValue
    }
    
    func didTapOperation(operation: OperationType) {
        if operation == .equality {
            isEqualityTapped = true
            setOperationResult()
        } else {
            if !isEqualityTapped {
                setOperationResult()
            }
            
            firstOperand = currentNumber
            secondOperand = nil
            currentOperation = operation
            isEqualityTapped = false
            isNewOperationSet = true
        }
    }
    
    func didTapUnaryOperation(unaryOperation: UnaryOperationType) {
        switch unaryOperation {
        case .clear:
            numbersViewModel.text = "0"
            currentOperation = nil
            firstOperand = nil
            secondOperand = nil
        case .plusMinus:
            guard !numbersViewModel.text.isEmpty else { return }
            if numbersViewModel.text.first == "-" {
                numbersViewModel.text = String(numbersViewModel.text.suffix(numbersViewModel.text.count - 1))
            } else {
                numbersViewModel.text = "-" + numbersViewModel.text
            }
        case .percent:
            let number = (Float(numbersViewModel.text) ?? 0) / 100.0
            guard number != 0 else { return }
            numbersViewModel.text = "\(number)"
        }
    }
}
