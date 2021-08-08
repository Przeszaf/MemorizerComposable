//
//  CardView.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGameCard
    
    @State private var animatedBonusRemaining : Double = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: -animatedBonusRemaining * 360 - 90))
                            .onAppear {
                                print(card.bonusRemaining)
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        // ERROR HERE - SHOULD BE -card.bonusRemaining * 360 - 90
                        // Otherwise start and end angle are the same
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: -card.bonusRemaining * 360 - 90))
                    }
                }
                .padding(DrawingConstants.circlePadding)
                .opacity(DrawingConstants.circleOpacity)
                Text(card.content)
                    .rotationEffect(Angle(degrees: card.isMatched ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
            
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }

    private enum DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let circleOpacity: Double = 0.5
        static let circlePadding: CGFloat = 5
        static let fontSize: CGFloat = 32
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: MemoryGameCard(id: 1, content: "👻")).foregroundColor(.red)
    }
}
