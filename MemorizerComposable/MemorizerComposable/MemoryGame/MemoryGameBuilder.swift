//
//  MemoryGameBuilder.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import Foundation

struct MemoryGameBuilder {
    let emojis = ["👻", "🎃", "🕷", "🧟‍♂️", "🍬","🧙‍♂️", "🍫", "🥧", "🥦", "🐲", "🕸", "🧚"]
    
    func build() {
        let initialState = MemoryGameState(numberOfPairsOfCards: 8) { pairIndex in
            return emojis[pairIndex]
        }
        
    }
}
