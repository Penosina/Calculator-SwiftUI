import SwiftUI

struct ButtonView: View {
    
    private let width: CGFloat
    @ObservedObject private var viewModel: ButtonViewModel
    
    init(viewModel: ButtonViewModel, width: CGFloat) {
        self.viewModel = viewModel
        self.width = width
    }
    
    var body: some View {
        Button(viewModel.title) {
            viewModel.action()
        }
        .font(Font.montserrat(size: viewModel.fontSize))
        .frame(width: viewModel.getRealWidth(fromWidth: width), height: width)
        .foregroundColor(viewModel.foregroundColor)
        .background(viewModel.backgroundColor)
        .cornerRadius(20)
        .shadow(color: Constants.Colors.blueShadow, radius: 5, x: 5, y: 5)
        .shadow(color: .white, radius: 5, x: -5, y: -5)
    }
}

struct CusstomButton_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(viewModel: ButtonViewModel(item: Item(key: .number("0"))), width: 200)
    }
}
