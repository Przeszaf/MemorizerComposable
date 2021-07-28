//
//  ContentView.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import ComposableArchitecture
import SwiftUI

struct MemoryGameView: View {
    let store: Store<MemoryGameState, MemoryGameAction>

    struct State: Equatable {
        var cards: [MemoryGameCard]
    }

    enum Action: Equatable {
        case choose(card: MemoryGameCard)
    }

    var body: some View {
        WithViewStore(self.store.scope(state: State.init, action: MemoryGameAction.init)) { viewStore in
            AspectVGrid(items: viewStore.cards, aspectRatio: 2 / 3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            viewStore.send(.choose(card: card))
                        }
                }
            }
            .foregroundColor(.red)
            .padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameBuilder().build()
    }
}
