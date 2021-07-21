//
//  MemoryGameCard.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import Foundation

struct MemoryGameCard<CardContent>: Equatable {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
}
