//
//  DemoAutocompleteToolbar.swift
//  Keyboard
//
//  Created by Peter on 26/05/22.
//  Based on KeyboardKitDemo by Daniel Saidi on 2020-06-22.
//

import KeyboardKit
import SwiftUI

/**
 This demo-specific toolbar applies a fixed height, to avoid
 resizing when it gets suggestions and when it's empty.
 */
struct DemoAutocompleteToolbar: View {
    
    @Binding public var isSystem :Bool

    @EnvironmentObject private var context: AutocompleteContext
    @EnvironmentObject private var keyboardContext: KeyboardContext
    
    var body: some View {
        if !context.suggestions.isEmpty {
            AutocompleteToolbar(
                    suggestions: Array(context.suggestions[0..<3]),
                    locale: keyboardContext.locale)
                    .frame(height: 50)
        }

        Toggle("ShowMore", isOn: $isSystem)
                .toggleStyle(.button)
                .tint(.mint)
    }
}

private extension DemoAutocompleteToolbar {
    
    var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}

struct DemoAutocompleteToolbar_Previews: PreviewProvider {
    
    static var previews: some View {
        DemoAutocompleteToolbar(isSystem:.constant(true))
    }
}
