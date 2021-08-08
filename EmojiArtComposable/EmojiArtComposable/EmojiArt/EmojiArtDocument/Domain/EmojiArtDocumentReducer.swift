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
    >.combine([
        EmojiArtDocumentBodyReducer
            .reducer
            .optional()
            .pullback(state: \.bodyState, action: /EmojiArtDocumentAction.bodyAction, environment: { _ in
                .init(imageClient: .live, mainQueue: .main)
            }),
        .init { state, action, env in
            switch action {
            case .bodyAction(.autosave):
                guard let jsonData = try? state.bodyState?.json() else { return .none }
                env.documentSaver.save(jsonData, env.documentSaver.autosaveFileName)
                return .none
            case .onAppear:
                state.bodyState = EmojiArtDocumentBodyState()
                return .none
            default:
                return .none
            }
        },
    ])
}
