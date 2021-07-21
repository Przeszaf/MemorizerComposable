//
//  MemoryGameState.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import Foundation

struct MemoryGameState<CardContent>: Equatable {
    private(set) var cards: Array<MemoryGameCard<CardContent>>
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<MemoryGameCard>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(MemoryGameCard<CardContent>(content: content))
            cards.append(MemoryGameCard<CardContent>(content: content))
        }
    }
}
