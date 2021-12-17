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
            case .bodyAction(.tryAutosaving): 
                guard let jsonData = try? state.bodyState?.json() else { return .none }
                return Effect(value: EmojiArtDocumentAction.autosave(jsonData))
                    .delay(for: 5.0, scheduler: env.timerScheduler)
                    .eraseToEffect()
                    .cancellable(id: "EmojiArtDocumentActionAutosave", cancelInFlight: true)
            case .onAppear:
                if let data = env.documentSaver.load(env.documentSaver.autosaveFileName),
                   let savedBodyState = try? EmojiArtDocumentBodyState(jsonData: data) {
                    state.bodyState = savedBodyState
                    return Effect(value: EmojiArtDocumentAction
                        .bodyAction(.setBackground(background: savedBodyState.background)))
                } else {
                    state.bodyState = EmojiArtDocumentBodyState()
                    return .none
                }
            case let .autosave(jsonData):
                env.documentSaver.save(jsonData, env.documentSaver.autosaveFileName)
                return .none
            default:
                return .none
            }
        },
    ])
}
