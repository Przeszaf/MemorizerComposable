//
//  MemoryGameState.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import Foundation

struct MemoryGameState: Equatable {
    var cards: Array<MemoryGameCard>
    var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> String) {
        cards = Array<MemoryGameCard>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(MemoryGameCard(content: content, id: pairIndex * 2))
            cards.append(MemoryGameCard(content: content, id: pairIndex * 2 + 1))
        }
    }
}
