//
//  AutocompleteKeyboardView.swift
//  SimpleKeyboard
//
//  Created by Peter on 26/05/22.
//

import KeyboardKit
import SwiftUI

/**
 This demo-specific toolbar applies a fixed height, to avoid
 resizing when it gets suggestions and when it's empty.
 */
struct AutocompleteKeyboardView: View {
    @Binding public var isSystem :Bool
    @EnvironmentObject private var context: AutocompleteContext
    @EnvironmentObject private var keyboardContext: KeyboardContext

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
    
        VStack{
            Button(action:{
                isSystem.toggle()
            }){
                Text("Back").padding()
            }
          if !context.suggestions.isEmpty {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(context.suggestions, id: \.title) { item in
                        Button(action:{
                            keyboardContext.textDocumentProxy.insertText(item.title+" ")
                            isSystem.toggle()
                        }){
                            Text(item.title).padding()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .frame(maxHeight: 250)
            }
        }
        
        
    }
}
