//
//  FakeAutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit
import UIKit
/**
 This fake provider simply returns the current word suffixed
 with "ly", "er" and "ter". It adds a subtitle to the middle
 suggestion as well, to show how subtitles can be used.
 */
class FakeAutocompleteProvider: AutocompleteProvider {
    
    var locale: Locale = .current
    
    var canIgnoreWords: Bool { false }
    var canLearnWords: Bool { false }
    // This is probably something we get people to set themselves on the app side of things.
    var ignoredWords: [String] = []
    var learnedWords: [String] = []
    let firstLetterDict = makeFirstLetterDict()
    let rowsList = getRows()
    
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




private extension FakeAutocompleteProvider {
    

    // uhh This probably only needs to be called once but I'm bad so I dont know how LMAOOO
    // dependant on above processes



    func suggestions(for text: String) -> [AutocompleteSuggestion] {
        guard let cLetterPosition = firstLetterDict[text[0]] else { return [] }
        
        // now we need to pull the closest 16 words
        return [
            // Need to pull the closest (X) word from words list.
            // So we need to...
            // look at words list, find text.
            // then take the next (16?) words from the words list.
            // e.g, user inputs a
            // locates the position that "a" would fill.
            // just doing 5 rn for demo
            suggestion(rowsList[cLetterPosition + 1][0]),
            suggestion(rowsList[cLetterPosition + 2][0]),
            suggestion(rowsList[cLetterPosition + 3][0]),
            suggestion(rowsList[cLetterPosition + 4][0]),
            suggestion(rowsList[cLetterPosition + 5][0]),

            // keep in mind this goes from 0 to 25
            suggestion(rowsList[cLetterPosition + 6][0]),
            suggestion(rowsList[cLetterPosition + 7][0]),
            suggestion(rowsList[cLetterPosition + 8][0]),
            suggestion(rowsList[cLetterPosition + 9][0]),
            suggestion(rowsList[cLetterPosition + 10][0]),
            suggestion(rowsList[cLetterPosition + 11][0]),
            suggestion(rowsList[cLetterPosition + 12][0]),
            suggestion(rowsList[cLetterPosition + 13][0]),
            suggestion(rowsList[cLetterPosition + 14][0]),
        ]
    }
    
    func suggestion(_ word: String, _ subtitle: String? = nil) -> AutocompleteSuggestion {
        StandardAutocompleteSuggestion(text: word, title: word, subtitle: subtitle)
    }
}
