//
//  EmojiArtDocumentBodyView+Action.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 08/08/2021.
//

import UIKit

extension EmojiArtDocumentBodyView {
    enum ViewAction: Equatable {
        case addEmoji(emoji: EmojiArtDocumentState.Emoji)
        case setBackground(background: EmojiArtDocumentState.Background)
        case moveEmoji(emoji: EmojiArtDocumentState.Emoji, offset: CGSize)
        case scaleEmoji(emoji: EmojiArtDocumentState.Emoji, scale: CGFloat)
    }
}

extension EmojiArtDocumentAction {
    init(action: EmojiArtDocumentBodyView.ViewAction) {
        switch action {
        case let .addEmoji(emoji):
            self = .addEmoji(emoji: emoji)
        case let .setBackground(background):
            self = .setBackground(background: background)
        case let .moveEmoji(emoji, offset):
            self = .moveEmoji(emoji: emoji, offset: offset)
        case let .scaleEmoji(emoji, scale):
            self = .scaleEmoji(emoji: emoji, scale: scale)
        }
    }
}


