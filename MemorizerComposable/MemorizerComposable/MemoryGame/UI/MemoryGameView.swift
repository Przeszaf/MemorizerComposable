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
    @Namespace private var dealingNamespace

    struct ViewState: Equatable {
        var cards: [MemoryGameCard]
    }

    enum ViewAction: Equatable {
        case choose(card: MemoryGameCard)
        case shuffle
        case restart
    }

    @State private var dealt = Set<Int>()

    private func deal(_ card: MemoryGameCard) {
        dealt.insert(card.id)
    }

    private func isUndealt(_ card: MemoryGameCard) -> Bool {
        !dealt.contains(card.id)
    }

    private func dealAnimation(for card: MemoryGameCard,
                               viewStore: ViewStore<ViewState, ViewAction>) -> Animation
    {
        var delay = 0.0
        if let index = viewStore.cards.firstIndex(of: card) {
            delay = Double(index) *
                (CardConstants.totalDealDuration / Double(viewStore.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }

    private func zIndex(of card: MemoryGameCard,
                        viewStore: ViewStore<ViewState, ViewAction>) -> Double
    {
        -Double(viewStore.cards.firstIndex(of: card) ?? 0)
    }

    var body: some View {
        WithViewStore(self.store.scope(
            state: ViewState.init, action: MemoryGameAction.init
        )) { viewStore in
            ZStack(alignment: .bottom) {
                VStack {
                    gameBody(viewStore: viewStore)
                    HStack {
                        restartButton(viewStore: viewStore)
                        Spacer()
                        shuffleButton(viewStore: viewStore)
                    }
                    .padding(.horizontal)
                }
                deckBody(viewStore: viewStore)
            }.padding()
        }
    }

    func gameBody(viewStore: ViewStore<ViewState, ViewAction>) -> some View {
        AspectVGrid(items: viewStore.cards, aspectRatio: CardConstants.aspectRatio) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .opacity))
                    .zIndex(zIndex(of: card, viewStore: viewStore))
                    .onTapGesture {
                        viewStore.send(.choose(card: card), animation: .default)
                    }
            }
        }
        .foregroundColor(CardConstants.color)
    }

    func shuffleButton(viewStore: ViewStore<ViewState, ViewAction>) -> some View {
        Button("Shuffle") {
            viewStore.send(.shuffle, animation: .default)
        }
    }

    func restartButton(viewStore: ViewStore<ViewState, ViewAction>) -> some View {
        Button("Restart") {
            withAnimation {
                dealt = []
                viewStore.send(.restart)
            }
        }
    }

    func deckBody(viewStore: ViewStore<ViewState, ViewAction>) -> some View {
        ZStack {
            ForEach(viewStore.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .zIndex(zIndex(of: card, viewStore: viewStore))
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            for card in viewStore.cards {
                withAnimation(dealAnimation(for: card, viewStore: viewStore)) {
                    deal(card)
                }
            }
        }
    }

    private enum CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2 / 3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameBuilder().build()
    }
}
