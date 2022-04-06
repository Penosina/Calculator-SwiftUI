import Foundation
import SwiftUI

// MARK: - ButtonViewModelDelegate
protocol ButtonViewModelDelegate: AnyObject {
    func didTapNumber(number: Number)
    func didTapOperation(operation: OperationType)
    func didTapUnaryOperation(unaryOperation: UnaryOperationType)
}

final class ButtonViewModel: ObservableObject {
    
    // MARK: - Properties
    weak var delegate: ButtonViewModelDelegate?
    
    @Published var backgroundColor: Color
    @Published var foregroundColor: Color
    
    var title: String {
        item.key.title
    }
    
    var fontSize: CGFloat {
        switch item.key.title {
        case OperationType.substraction.rawValue:
            return 45
        case OperationType.division.rawValue:
            return 43
        default:
            return 29
        }
    }
    
    private let item: Item
    private var operationType: OperationType {
        switch title {
        case OperationType.division.rawValue:
            return OperationType.division
        case OperationType.multiplication.rawValue:
            return OperationType.multiplication
        case OperationType.substraction.rawValue:
            return OperationType.substraction
        case OperationType.addition.rawValue:
            return OperationType.addition
        case OperationType.equality.rawValue:
            return OperationType.equality
        default:
            return OperationType.equality
        }
    }
    
    private var unaryOperation: UnaryOperationType {
        switch title {
        case UnaryOperationType.clear.rawValue:
            return UnaryOperationType.clear
        case UnaryOperationType.plusMinus.rawValue:
            return UnaryOperationType.plusMinus
        case UnaryOperationType.percent.rawValue:
            return UnaryOperationType.percent
        default:
            return UnaryOperationType.clear
        }
    }
    
    private var number: Number {
        switch title {
        case Number.zero.rawValue:
            return Number.zero
        case Number.one.rawValue:
            return Number.one
        case Number.two.rawValue:
            return Number.two
        case Number.three.rawValue:
            return Number.three
        case Number.four.rawValue:
            return Number.four
        case Number.five.rawValue:
            return Number.five
        case Number.six.rawValue:
            return Number.six
        case Number.seven.rawValue:
            return Number.seven
        case Number.eight.rawValue:
            return Number.eight
        case Number.nine.rawValue:
            return Number.nine
        case Number.comma.rawValue:
            return Number.comma
        default:
            return Number.zero
        }
    }
    
    // MARK: - Init
    init(item: Item) {
        self.item = item
        
        switch item.key.title {
        case OperationType.division.rawValue, OperationType.multiplication.rawValue, OperationType.substraction.rawValue, OperationType.addition.rawValue, OperationType.equality.rawValue:
            backgroundColor = Constants.Colors.blue
            foregroundColor = .white
        default:
            backgroundColor = Constants.Colors.lightGray
            foregroundColor = Constants.Colors.blue
        }
    }
    
    // MARK: - Public Methods
    func getRealWidth(fromWidth width: CGFloat) -> CGFloat {
        if item.widthRatio == 2 {
            return width * CGFloat(item.widthRatio) + 16
        }
        
        return width
    }
    
    func action() {
        switch item.key {
        case .number:
            delegate?.didTapNumber(number: number)
        case .operation:
            delegate?.didTapOperation(operation: operationType)
        case .unaryOperation:
            delegate?.didTapUnaryOperation(unaryOperation: unaryOperation)
        }
    }
}
