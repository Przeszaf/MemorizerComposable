//
//  MemoryGameBuilder.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import SwiftUI
import ComposableArchitecture

struct MemoryGameBuilder {
    private let emojis = ["👻", "🎃", "🕷", "🧟‍♂️", "🍬","🧙‍♂️", "🍫", "🥧", "🥦", "🐲", "🕸", "🧚"]
    
    func build() -> some View {
        return MemoryGameView(store: Store(initialState: MemoryGameState(numberOfPairsOfCards: 8, createCardContent: { pairIndex in
            return emojis[pairIndex]
        }),
        reducer: MemoryGameReducer.appReducer,
        environment: MemoryGameEnvironment()))
    }
}
