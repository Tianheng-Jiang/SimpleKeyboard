//
//  FakeAutocompleteProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import KeyboardKit

/**
 This fake provider simply returns the current word suffixed
 with "ly", "er" and "ter". It adds a subtitle to the middle
 suggestion as well, to show how subtitles can be used.
 */
class FakeAutocompleteProvider: AutocompleteProvider {
    
    var locale: Locale = .current
    
    var canIgnoreWords: Bool { false }
    var canLearnWords: Bool { false }
    var ignoredWords: [String] = []
    var learnedWords: [String] = []
    
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
    
    func suggestions(for text: String) -> [AutocompleteSuggestion] {
        [
            suggestion(text + "1"),
            suggestion(text + "2"),
            suggestion(text + "3"),
            suggestion(text + "4"),
            suggestion(text + "5"),
            suggestion(text + "6"),
            suggestion(text + "7"),
            suggestion(text + "8"),
            suggestion(text + "9"),
            suggestion(text + "A"),
            suggestion(text + "B"),
            suggestion(text + "C"),
            suggestion(text + "E"),
            suggestion(text + "F"),
            suggestion(text + "G"),
            suggestion(text + "H"),
            suggestion(text + "I"),
        ]
    }
    
    func suggestion(_ word: String, _ subtitle: String? = nil) -> AutocompleteSuggestion {
        StandardAutocompleteSuggestion(text: word, title: word, subtitle: subtitle)
    }
}
