//
//  MemoryGameState.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import Foundation

struct MemoryGameState: Equatable {
    var cards: [MemoryGameCard]
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp == true }.oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue } }
    }

    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> String) {
        cards = []
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(MemoryGameCard(content: content, id: pairIndex * 2))
            cards.append(MemoryGameCard(content: content, id: pairIndex * 2 + 1))
        }
    }
}
