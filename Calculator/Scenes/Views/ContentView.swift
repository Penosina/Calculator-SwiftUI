import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: MainViewModel = MainViewModel()
    var body: some View {
        ZStack {
            Constants.Colors.lightGray.ignoresSafeArea()
            GeometryReader { geometry in
                let width = (geometry.size.width - 92) / 4
                VStack(spacing: 16) {
                    HStack {
                        Text("Calculator")
                            .font(Font.museo(size: 28))
                            .padding(.leading, 24.0)
                        Spacer()
                    }
                    
                    NumbersView(viewModel: viewModel.getNumbersViewModel())
                        .padding(.horizontal, 22.0)
                        .frame(height: geometry.size.height * 0.15)
                    VStack(spacing: 16) {
                        ForEach(0..<viewModel.rowNum) { row in
                            HStack(spacing: 16) {
                                ForEach(0..<viewModel.getButtonsCount(atRow: row)) {
                                    column in
                                    let buttonViewModel = viewModel.getButtonViewModel(row: row, column: column)
                                    ButtonView(viewModel: buttonViewModel, width: width)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension Constants.Dimentions {

}
