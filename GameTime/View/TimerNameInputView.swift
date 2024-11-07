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
    
    // Used to dismiss the view
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            GTTextFieldView(text: $text)
                .onSubmit {
                    dismiss()
                }
        }
        .padding(.horizontal)
        .navigationTitle("Name")
    }
}

struct TimerNameInputView_Previews: PreviewProvider {
    static var previews: some View {
        TimerNameInputView(text: .constant("Player #2"))
            .preferredColorScheme(.dark)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}
