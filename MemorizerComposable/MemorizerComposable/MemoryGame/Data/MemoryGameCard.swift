//
//  MemoryGameCard.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import Foundation

struct MemoryGameCard: Identifiable, Equatable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    let content: String
    let id: Int
}
