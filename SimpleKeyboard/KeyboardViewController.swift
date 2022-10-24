import KeyboardKit
import SwiftUI
//
//  KeyboardViewController.swift
//  SimpleKeyboard
//
//  Created by Peter on 8/05/22.
//
class KeyboardViewController: KeyboardInputViewController {
    

    var db:DBHelper = DBHelper()

    /**
     In this demo, we will only configure KeyboardKit to use
     a demo-specific, unicode-based input set provider.
     */
    override func viewDidLoad() {
        
//        // Inject a demo-specific unicode input set provider
//        // 💡 Play with this to change the keyboard's layout
//        inputSetProvider = DemoInputSetProvider()

        let rows = getRows()

        // loop through rows
        for row in rows {
            db.insert(texts: row[0], emoji: row[1])
        }
        
//        // Inject a demo-specific unicode input set provider
//        // 💡 Play with this to change the keyboard's layout
//        inputSetProvider = DemoInputSetProvider()


        autocompleteProvider = SimpleAutocompleteProvider()
//        // Setup a demo-specific keyboard appearance
//        // 💡 Play with this to change style of the keyboard
//        keyboardAppearance = DemoKeyboardAppearance(context: keyboardContext)
//
//        // Setup a demo-specific keyboard action handler
//        // 💡 Play with this to change the keyboard behavior
//        keyboardActionHandler = DemoKeyboardActionHandler(
//                inputViewController: self)
//
//        // Setup a demo-specific keyboard layout provider
//        // 💡 Play with this to change the keyboard's layout
//        keyboardLayoutProvider = DemoKeyboardLayoutProvider(
//                inputSetProvider: inputSetProvider,
//                dictationReplacement: nil)
        // Call super to perform the base initialization
        super.viewDidLoad()
    }
    
    /**
     This function is called whenever the keyboard should be
     created or updated.
     
     Here, we call setup with a demo-specific view that uses
     ``SystemKeyboard`` to mimic a native iOS keyboard.
     */
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()
        
        // Setup a demo-specific keyboard view
        setup(with: KeyboardView())
    }
}
