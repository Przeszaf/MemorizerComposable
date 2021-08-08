//
//  EmojiArtDocumentBodyView+Action.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 08/08/2021.
//

import UIKit

extension EmojiArtDocumentBodyView {
    enum ViewAction: Equatable {
        case addEmoji(emoji: EmojiArtDocumentBodyState.Emoji)
        case setBackground(background: EmojiArtDocumentBodyState.Background)
        case moveEmoji(emoji: EmojiArtDocumentBodyState.Emoji, offset: CGSize)
        case scaleEmoji(emoji: EmojiArtDocumentBodyState.Emoji, scale: CGFloat)
    }
}

extension EmojiArtDocumentBodyAction {
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


