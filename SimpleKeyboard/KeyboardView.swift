//
//  KeyboardView.swift
//  KeyboardKitDemo
//
//
//  Created by Peter on 26/05/22.
//  Based on KeyboardKitDemo by Daniel Saidi on 2020-06-22.
//

import KeyboardKit
import SwiftUI

/**
 This is the main view that is registered when the extension
 calls `setup(with:)` in `KeyboardViewController`.
 
 The view must observe the KeyboardContext as an environment
 object or inject an instance and then set it to an observed
 object (commented out). Otherwise this view will not change
 when the context changes.
 */
struct KeyboardView: View {
    
    /*
    init(context: KeyboardContext) {
       _context = ObservedObject(wrappedValue: context)
    }
    */
    
    @State private var text = "Text"
    
    @State public var isSystem = true
    // @ObservedObject private var context: KeyboardContext
    
    @EnvironmentObject private var context: KeyboardContext
    
    var body: some View {
        VStack(spacing: 0) {
            if context.keyboardType != .emojis && isSystem {
                DemoAutocompleteToolbar(isSystem:$isSystem)
            }
            if isSystem {
                SystemKeyboard()
            }else{
                AutocompleteKeyboardView(isSystem:$isSystem)
            }
        }
    }
}


// MARK: - Private Views

private extension KeyboardView {
    
    var textField: some View {
        KeyboardTextField(text: $text) {
            $0.placeholder = "Try typing here, press return to stop."
            $0.borderStyle = .roundedRect
            $0.autocapitalizationType = .sentences
        }.padding(3)
    }
}


struct KeyboardView_Preview: PreviewProvider{
    static var previews: some View{
        KeyboardView()
    }
}
