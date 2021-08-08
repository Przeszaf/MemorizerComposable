//
//  EmojiArtReducer.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import ComposableArchitecture
import UIKit

class EmojiArtDocumentReducer {
    static let reducer = Reducer<
        EmojiArtDocumentState,
        EmojiArtDocumentAction,
        EmojiArtDocumentEnvironment
    >
    .init { state, action, environment in
        switch action {
        case let .addEmoji(emoji):
            state.emojis.append(EmojiArtDocumentState.Emoji(
                text: emoji.text,
                x: emoji.x,
                y: emoji.y,
                size: emoji.size
            ))
            autosave(state: state, environment: environment)
        case let .setBackground(background):
            state.background = background
            autosave(state: state, environment: environment)
            switch background {
            case .blank:
                return Effect(value: EmojiArtDocumentAction.setBackgroundImage(image: nil))
                    .eraseToEffect()
            case let .imageData(data):
                return Effect(value: EmojiArtDocumentAction.setBackgroundImage(image: UIImage(data: data)))
                    .eraseToEffect()
            case let .url(url):
                state.backgroundImage = nil
                state.backgroundImageFetchStatus = .fetching
                return environment.imageClient.fetchFromURL(url)
                    .receive(on: environment.mainQueue)
                    .eraseToEffect()
                    .map(EmojiArtDocumentAction.setBackgroundImage)
                    .cancellable(id: EmojiArtDocumentImageClient.ImageClientFetchId(), cancelInFlight: true)
            }
        case let .moveEmoji(emoji, offset):
            if let index = state.emojis.index(matching: emoji) {
                state.emojis[index].x += Int(offset.width)
                state.emojis[index].y += Int(offset.height)
            }
            autosave(state: state, environment: environment)
        case let .scaleEmoji(emoji, scale):
            if let index = state.emojis.index(matching: emoji) {
                state.emojis[index]
                    .size = Int((CGFloat(state.emojis[index].size) * scale)
                        .rounded(.toNearestOrAwayFromZero))
            }
            autosave(state: state, environment: environment)
        case let .setBackgroundImage(image):
            state.backgroundImage = image
            state.backgroundImageFetchStatus = .idle
        }
        return .none
    }

    private static func autosave(state: EmojiArtDocumentState, environment: EmojiArtDocumentEnvironment) {
        guard let jsonData = try? state.json() else { return }
        environment.documentSaver.save(jsonData, EmojiArtDocumentSaver.autosaveFileName)
    }
}
