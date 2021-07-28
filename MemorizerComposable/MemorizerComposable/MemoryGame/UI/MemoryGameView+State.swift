//
//  MemoryGameView+State.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 28/07/2021.
//

import Foundation

extension MemoryGameView.State {
    init(state: MemoryGameState) {
        self.init(cards: state.cards)
    }
}
