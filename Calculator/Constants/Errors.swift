import Foundation
enum Errors: LocalizedError {
    case indexOutOfRange, dividedByZero
    
    var errorDescription: String? {
        switch self {
        case .indexOutOfRange:
            return "Index out of range"
        case .dividedByZero:
            return "Ошибка."
        }
    }
}
