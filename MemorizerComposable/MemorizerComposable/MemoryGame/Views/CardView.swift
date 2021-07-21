//
//  CardView.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGameCard
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).foregroundColor(.black).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: MemoryGameCard(content: "👻", id: 1))
    }
}
