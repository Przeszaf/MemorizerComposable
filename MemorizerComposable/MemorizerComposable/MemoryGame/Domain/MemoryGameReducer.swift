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
                state.indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in state.cards.indices {
                    state.cards[index].isFaceUp = false
                }
                state.indexOfTheOneAndOnlyFaceUpCard = index
            }
            state.cards[index].isFaceUp.toggle()
            return .none
        }
    }
}
