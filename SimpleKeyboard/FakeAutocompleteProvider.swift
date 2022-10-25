//
//  FakeAutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Peter on 26/05/22.
//  Based on KeyboardKitDemo by Daniel Saidi on 2020-06-22.
//

import Foundation
import KeyboardKit
import UIKit
/**
 This fake provider simply returns the current word suffixed
 with "ly", "er" and "ter". It adds a subtitle to the middle
 suggestion as well, to show how subtitles can be used.
 */
class SimpleAutocompleteProvider: AutocompleteProvider {
    
    var locale: Locale = .current
    
    var canIgnoreWords: Bool { false }
    var canLearnWords: Bool { false }
    // This is probably something we get people to set themselves on the app side of things.
    var ignoredWords: [String] = []
    var learnedWords: [String] = []
    let firstLetterDict = makeFirstLetterDict()
    let rowsList = getRows()
    let db:DBHelper = DBHelper()
    
    func hasIgnoredWord(_ word: String) -> Bool { false }
    func hasLearnedWord(_ word: String) -> Bool { false }
    func ignoreWord(_ word: String) {}
    func learnWord(_ word: String) {}
    func removeIgnoredWord(_ word: String) {}
    func unlearnWord(_ word: String) {}
    
    
    func autocompleteSuggestions(for text: String, completion: AutocompleteCompletion) {
        guard text.count > 0 else { return completion(.success([])) }

        completion(.success(suggestions(for: text)))
    }
}




private extension SimpleAutocompleteProvider {
    

    // uhh This probably only needs to be called once but I'm bad so I dont know how LMAOOO
    // dependant on above processes



    func suggestions(for text: String) -> [AutocompleteSuggestion] {
        var phrases = db.readStartWith(startText:text)
        // print all phrases in the list
        // number of phrases is less than 3 and greater than 0
        if phrases.count < 3 && phrases.count > 0 {
            let restPhrase =  phrases[0]
            for _ in 0..<3-phrases.count {
                phrases.append(restPhrase)
            }
        }
        
        // now we need to pull the closest 16 words [Actually, let's do all of them]
        
        return phrases.map{suggestion($0.texts,$0.emoji)}
    }
    
    func suggestion(_ word: String, _ subtitle: String? = nil) -> AutocompleteSuggestion {
        StandardAutocompleteSuggestion(text: word, title: word, subtitle: subtitle)
    }
}
