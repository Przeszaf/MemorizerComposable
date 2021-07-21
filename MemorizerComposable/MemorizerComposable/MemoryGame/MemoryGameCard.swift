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
    var content: String

    var id: Int

    static func == (lhs: MemoryGameCard, rhs: MemoryGameCard) -> Bool {
        lhs.id == rhs.id &&
            lhs.isFaceUp == rhs.isFaceUp &&
            lhs.isMatched == rhs.isMatched &&
            lhs.content == rhs.content
    }
}
