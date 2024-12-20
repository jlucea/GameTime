
import SwiftUI
import Combine

public struct GTTextFieldView: View {
    
    @Binding var text : String
    @FocusState private var textFieldFocus: Bool
    let maxLength = 25
    
    public var body: some View {
        TextField("", text: $text)
            .autocorrectionDisabled()
            .submitLabel(.done)
            .padding()
            .focused($textFieldFocus)   // Link to the variable defining focus
            .onAppear {
                // Set focus upon appearing
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                    self.textFieldFocus = true
                }
            }
            .onReceive(Just(text)) { _ in limitText(maxLength)}
            .modifier(ClearButtonTextFieldViewModifier(text: $text))
            .background(Color(UIColor.systemGray5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    // Function to keep text length in limits
    func limitText(_ charlimit: Int) {
        if text.count > charlimit {
            text = String(text.prefix(charlimit))
        }
    }
}

///
/// This ViewModifier will add a clear button to a TextField
///
public struct ClearButtonTextFieldViewModifier: ViewModifier {
    
    @Binding var text: String
    
    public func body(content: Content) -> some View {
        HStack {
            content
            
            if !text.isEmpty {
                Button {
                    self.text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color.gray)
                }
                .padding(.trailing, 12)
            }
        }
    }
}

#Preview {
    GTTextFieldView(text: State(wrappedValue: "Romulus").projectedValue)
        .padding(.horizontal, 40)
}
