//
//  Phrase.swift
//  SimpleKeyboard
//
//  Created by Peter on 24/10/22.
//

import Foundation
class Phrase {
    
    var texts : String = ""
    var emoji: String = ""
    var id: Int32 = 0
    
    init(id:Int32, texts:String, emoji:String) {
        self.texts = texts
        self.emoji = emoji
        self.id = id
    }
}
