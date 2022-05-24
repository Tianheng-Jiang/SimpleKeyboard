//
//  DemoAutocompleteToolbar.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-09-16.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/**
 This demo-specific toolbar applies a fixed height, to avoid
 resizing when it gets suggestions and when it's empty.
 */
struct DemoAutocompleteToolbar: View {
    
    @EnvironmentObject private var context: AutocompleteContext
    @EnvironmentObject private var keyboardContext: KeyboardContext


    @State private var show = false

    var body: some View {
            if show {
                AutocompleteToolbar(
                        suggestions: Array(context.suggestions[0..<3]),
                        locale: keyboardContext.locale)
                        .frame(height: 50)
            }

            Toggle("ShowMore", isOn: $show)
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
        DemoAutocompleteToolbar()
    }
}
