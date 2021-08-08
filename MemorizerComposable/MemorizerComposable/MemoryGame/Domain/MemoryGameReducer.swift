//
//  MemoryGameReducer.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import ComposableArchitecture
import Foundation

class MemoryGameReducer {
    static let appReducer = Reducer<MemoryGameState, MemoryGameAction, MemoryGameEnvironment>.init { state, action, _ in
        switch action {
        case .choose(let card):
            guard let index = state.cards.firstIndex(of: card),
                  !state.cards[index].isFaceUp,
                  !state.cards[index].isMatched else { return .none }
            if let potentialMatchIndex = state.indexOfTheOneAndOnlyFaceUpCard {
                if state.cards[index].content == state.cards[potentialMatchIndex].content {
                    state.cards[index].isMatched = true
                    state.cards[potentialMatchIndex].isMatched = true
                }
                state.cards[index].isFaceUp = true
            } else {
                state.indexOfTheOneAndOnlyFaceUpCard = index
            }
            return .none
        case .shuffle:
            state.cards.shuffle()
            return .none
        case .restart:
            state = MemoryGameBuilder().getInitialState()
            return .none
        }
    }
}
