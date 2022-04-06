import Foundation
enum OperationType: String {
    case division = "÷"
    case multiplication = "X"
    case substraction = "-"
    case addition = "+"
    case equality = "="
    
    func calculate(first: Decimal, second: Decimal) throws -> Decimal {
        switch self {
        case .division:
            guard second != 0 else {
                throw Errors.dividedByZero
            }
            
            return first / second
        case .multiplication:
            return first * second
        case .substraction:
            return first - second
        case .addition:
            return first + second
        default:
            return 0
        }
    }
}


