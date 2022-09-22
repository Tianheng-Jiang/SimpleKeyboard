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
        GridItem(.flexible(),spacing: 2),
        GridItem(.flexible(),spacing: 2),
        GridItem(.flexible(),spacing: 2)
    ]
    
    var body: some View {
        if context.suggestions.isEmpty {
            Button(action:{
                isSystem.toggle()
            }){
                Text("No suggestions").padding()
            }
        }else{
            Button(action:{
                isSystem.toggle()
            }){
            Image(systemName: "chevron.left.square.fill")
            }
            
        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(context.suggestions, id: \.title) { suggestion in
                    Button(action: {
                        keyboardContext.textDocumentProxy.insertText(suggestion.title+" ")
                        isSystem.toggle()
                    }) {
                        Text(suggestion.title)
                            .frame(maxWidth: .infinity,maxHeight: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .frame(maxHeight: 250)
        }
    }
}
