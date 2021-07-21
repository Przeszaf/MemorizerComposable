//
//  MemoryGameReducer.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import Foundation
import ComposableArchitecture

class MemoryGameReducer {
    static let appReducer = Reducer<MemoryGameState, MemoryGameAction, MemoryGameEnvironment>.init { state, action, _ in
        return .none
    }
}
