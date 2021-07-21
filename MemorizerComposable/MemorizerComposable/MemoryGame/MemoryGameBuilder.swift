//
//  MemoryGameBuilder.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import SwiftUI
import ComposableArchitecture

struct MemoryGameBuilder {
    let emojis = ["👻", "🎃", "🕷", "🧟‍♂️", "🍬","🧙‍♂️", "🍫", "🥧", "🥦", "🐲", "🕸", "🧚"]
    
    func build() -> some View {
        return MemoryGameView(store: Store(initialState: MemoryGameState(numberOfPairsOfCards: 4, createCardContent: { pairIndex in
            return emojis[pairIndex]
        }),
        reducer: MemoryGameReducer.appReducer,
        environment: MemoryGameEnvironment()))
    }
}
