
import SwiftUI

struct TimePickerView: View {
    
    private let data: [[String]] = [
        Array(0...10).map { "\($0) h" },
        Array(0...59).map { "\($0) min" }
    ]

    @State var selections: [Int] = [0, 35]

    var body: some View {
        VStack {
            PickerView(data: self.data, selections: self.$selections)

            Text("\(self.data[0][self.selections[0]]) \(self.data[1][self.selections[1]])")
        }
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView()
    }
}
