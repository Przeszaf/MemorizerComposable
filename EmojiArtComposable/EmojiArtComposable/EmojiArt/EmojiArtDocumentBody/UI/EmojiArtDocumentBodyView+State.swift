//
//  EmojiArtDocumentBodyView+State.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 08/08/2021.
//

import UIKit

extension EmojiArtDocumentBodyView {
    struct ViewState: Equatable {
        var emojis: [EmojiArtDocumentBodyState.Emoji]
        var backgroundImage: UIImage?
        var backgroundImageFetchStatus: EmojiArtDocumentBodyState.BackgroundImageFetchStatus
        
        init(state: EmojiArtDocumentBodyState) {
            self.emojis = state.emojis
            self.backgroundImage = state.backgroundImage
            self.backgroundImageFetchStatus = state.backgroundImageFetchStatus
        }
    }
}
