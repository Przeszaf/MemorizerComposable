//
//  MemoryGameView+Action.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 28/07/2021.
//

import Foundation

extension MemoryGameAction {
    init(viewAction: MemoryGameView.ViewAction) {
        switch viewAction {
        case .choose(let card):
            self = .choose(card: card)
        case .shuffle:
            self = .shuffle
        case .restart:
            self = .restart
        }
    }
}
