import Foundation

final class Validator {
    static func validateCalcText(text: String) -> String {
        return text.replacingOccurrences(of: ".", with: ",")
    }
    
    static func getNumberFromString(text: String) -> Decimal {
        return Decimal(string: text.replacingOccurrences(of: ",", with: ".")) ?? 0
    }
}
