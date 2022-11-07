//
//  TimerNameInputView.swift
//  GameTime
//
//  Created by Jaime Lucea on 7/11/22.
//

import SwiftUI

/*
 * This is a view containing only a TextField
 */
struct TimerNameInputView : View {

    @Binding var text : String
    
    @FocusState private var textFieldFocus: Bool

    // Used to dismiss the view
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {

        VStack {
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
                .onSubmit {
                    dismiss()
                }
                .modifier(TextFieldClearButton(text: $text))
                .background(Color(UIColor.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(.horizontal)
        .navigationTitle("Name")
    }
    
    /*
     * This ViewModifier will add a clear button to a TextField
     */
    struct TextFieldClearButton: ViewModifier {
        
        @Binding var text: String
        
        func body(content: Content) -> some View {
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

}

struct TimerNameInputView_Previews: PreviewProvider {
    static var previews: some View {
        TimerNameInputView(text: .constant("Player #2"))
            .preferredColorScheme(.dark)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}
