enum KeyType {
    var title: String {
        switch self {
        case .number(let key), .operation(let key), .unaryOperation(let key):
            return key
        }
    }
    
    case number(String), operation(String), unaryOperation(String)
}
