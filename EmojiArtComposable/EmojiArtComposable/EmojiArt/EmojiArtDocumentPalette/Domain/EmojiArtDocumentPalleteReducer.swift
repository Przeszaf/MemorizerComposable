//
//  EmojiArtDocumentPalleteReducer.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 18/09/2021.
//

import ComposableArchitecture
import Foundation

class EmojiArtDocumentPalleteReducer {
    static let reducer = Reducer<
        EmojiArtDocumentPalleteState,
        EmojiArtDocumentPalleteAction,
        EmojiArtDocumentPalleteEnvironment
    >.init { state, action, env in
        return .none
    }
}
