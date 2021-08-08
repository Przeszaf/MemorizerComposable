//
//  EmojiArtReducer.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import ComposableArchitecture
import UIKit

class EmojiArtDocumentReducer {
    static let reducer = Reducer<EmojiArtDocumentState, EmojiArtDocumentAction, EmojiArtDocumentEnvironment>
        .init { state, action, _ in
            switch action {
            case let .addEmoji(emoji):
                state.emojis.append(EmojiArtDocumentState.Emoji(
                    text: emoji.text,
                    x: emoji.x,
                    y: emoji.y,
                    size: emoji.size
                ))
            case let .addBackground(background):
                state.background = background
            case let .moveEmoji(emoji, offset):
                if let index = state.emojis.index(matching: emoji) {
                    state.emojis[index].x += Int(offset.width)
                    state.emojis[index].y += Int(offset.height)
                }
            case let .scaleEmoji(emoji, scale):
                if let index = state.emojis.index(matching: emoji) {
                    state.emojis[index]
                        .size = Int((CGFloat(state.emojis[index].size) * scale)
                            .rounded(.toNearestOrAwayFromZero))
                }
            }
            return .none
        }
}
