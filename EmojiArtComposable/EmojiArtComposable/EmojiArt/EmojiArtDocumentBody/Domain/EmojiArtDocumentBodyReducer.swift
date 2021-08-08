//
//  EmojiArtDocumentBodyReducer.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 08/08/2021.
//

import ComposableArchitecture
import UIKit

class EmojiArtDocumentBodyReducer {
    static let reducer = Reducer<
        EmojiArtDocumentBodyState,
        EmojiArtDocumentBodyAction,
        EmojiArtDocumentBodyEnvironment
    >
    .init { state, action, environment in
        switch action {
        case let .addEmoji(emoji):
            state.emojis.append(EmojiArtDocumentBodyState.Emoji(
                text: emoji.text,
                x: emoji.x,
                y: emoji.y,
                size: emoji.size
            ))
            return Effect(value: EmojiArtDocumentBodyAction.tryAutosaving)
        case let .setBackground(background):
            state.background = background
            switch background {
            case .blank:
                return .merge(
                    Effect(value: EmojiArtDocumentBodyAction.setBackgroundImage(image: nil)),
                    Effect(value: EmojiArtDocumentBodyAction.tryAutosaving)
                )
            case let .imageData(data):
                return .merge(
                    Effect(value: EmojiArtDocumentBodyAction.setBackgroundImage(image: UIImage(data: data))),
                    Effect(value: EmojiArtDocumentBodyAction.tryAutosaving)
                )
            case let .url(url):
                state.backgroundImage = nil
                state.backgroundImageFetchStatus = .fetching
                return .merge(
                    environment.imageClient.fetchFromURL(url)
                        .receive(on: environment.mainQueue)
                        .eraseToEffect()
                        .map(EmojiArtDocumentBodyAction.setBackgroundImage)
                        .cancellable(id: EmojiArtDocumentBodyImageClient.ImageClientFetchId(), cancelInFlight: true),
                    Effect(value: EmojiArtDocumentBodyAction.tryAutosaving)
                )
            }
        case let .moveEmoji(emoji, offset):
            if let index = state.emojis.index(matching: emoji) {
                state.emojis[index].x += Int(offset.width)
                state.emojis[index].y += Int(offset.height)
            }
            return Effect(value: EmojiArtDocumentBodyAction.tryAutosaving)
        case let .scaleEmoji(emoji, scale):
            if let index = state.emojis.index(matching: emoji) {
                state.emojis[index]
                    .size = Int((CGFloat(state.emojis[index].size) * scale)
                        .rounded(.toNearestOrAwayFromZero))
            }
            return Effect(value: EmojiArtDocumentBodyAction.tryAutosaving)
        case let .setBackgroundImage(image):
            state.backgroundImage = image
            state.backgroundImageFetchStatus = .idle
        case .tryAutosaving:
            return .none
        }
        return .none
    }
}
