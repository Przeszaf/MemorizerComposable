//
//  EmojiArtBuilder.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import ComposableArchitecture
import SwiftUI

struct EmojiArtDocumentBuilder {
    func build() -> some View {
        return EmojiArtDocumentView(store: getStore())
    }

    func getStore() -> Store<EmojiArtDocumentState, EmojiArtDocumentAction> {
        Store(initialState: getInitialState(),
              reducer: EmojiArtDocumentReducer.reducer,
              environment: EmojiArtDocumentEnvironment(
                  imageClient: .live,
                  documentSaver: .live,
                  mainQueue: DispatchQueue.main
              ))
    }

    func getInitialState() -> EmojiArtDocumentState {
        EmojiArtDocumentState() 
    }
}
