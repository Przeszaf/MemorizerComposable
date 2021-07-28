//
//  CardView.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGameCard

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 120 - 90))
                    .padding(DrawingConstants.circlePadding)
                    .opacity(DrawingConstants.circleOpacity)
                Text(card.content).foregroundColor(.black).font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }

    private func font(in size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }

    private enum DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let circleOpacity: Double = 0.5
        static let circlePadding: CGFloat = 5
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: MemoryGameCard(content: "👻", id: 1)).foregroundColor(.red)
    }
}
