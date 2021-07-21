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

    var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(viewStore.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2 / 3, contentMode: .fit)
                            .onTapGesture {
                                viewStore.send(.choose(card: card))
                            }
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
