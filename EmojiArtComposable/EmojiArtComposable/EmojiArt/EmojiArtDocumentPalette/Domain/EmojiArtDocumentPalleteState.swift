//
//  EmojiArtDocumentPalleteState.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 18/09/2021.
//

import Foundation


struct EmojiArtDocumentPalleteState: Equatable {
    let palletes: [Pallete]
    
    struct Pallete: Equatable {
        let name: String
        let emojis: [String]
        let id: Int
    }
}
