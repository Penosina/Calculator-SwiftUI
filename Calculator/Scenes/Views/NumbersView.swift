import SwiftUI

struct NumbersView: View {
    @ObservedObject var viewModel: NumbersViewModel
    
    init(viewModel: NumbersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(LinearGradient(colors: [
                    Constants.Colors.lightGradientGreen,
                    Constants.Colors.darkGradientGreen
                ], startPoint: .topLeading, endPoint: .bottomTrailing))
                .overlay(
                    RoundedRectangle(cornerRadius: 16).stroke(Constants.Colors.lightGray, lineWidth: 4)
                        .shadow(color: .black.opacity(0.251), radius: 4)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                )
            ZStack(alignment: .leading) {
                Text(viewModel.backgroundText)
                    .foregroundColor(Constants.Colors.darkGreen.opacity(0.1))
                    .font(Font.digitalNumbers(size: 40))
                Text(viewModel.text)
                    .lineLimit(1)
                    .foregroundColor(Constants.Colors.darkGreen)
                    .font(Font.digitalNumbers(size: 40))
            }
        }
    }
}

struct NumbersView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersView(viewModel: NumbersViewModel())
    }
}
