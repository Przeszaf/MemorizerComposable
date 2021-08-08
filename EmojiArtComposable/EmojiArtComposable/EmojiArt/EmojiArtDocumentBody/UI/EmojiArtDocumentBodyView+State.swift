//
//  EmojiArtDocumentBodyView+State.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 08/08/2021.
//

import UIKit

extension EmojiArtDocumentBodyView {
    struct ViewState: Equatable {
        var emojis: [EmojiArtDocumentState.Emoji]
        var backgroundImage: UIImage?
        var backgroundImageFetchStatus: EmojiArtDocumentState.BackgroundImageFetchStatus
        
        init(state: EmojiArtDocumentState) {
            self.emojis = state.emojis
            self.backgroundImage = state.backgroundImage
            self.backgroundImageFetchStatus = state.backgroundImageFetchStatus
        }
    }
}
