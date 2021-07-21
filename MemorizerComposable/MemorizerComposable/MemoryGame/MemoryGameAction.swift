//
//  MemoryGameAction.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import Foundation

enum MemoryGameAction: Equatable {
    case chooseCard(card: MemoryGameCard)
}

struct ApiError: Error, Equatable {}
