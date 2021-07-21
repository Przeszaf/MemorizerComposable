//
//  CardView.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import SwiftUI

struct CardView: View {
    @State var isUp = true
    let emoji: String
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isUp {
                shape.fill()
            } else {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(emoji).foregroundColor(.black)
            }
        }.onTapGesture {
            isUp = !isUp
        }.foregroundColor(.red)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(emoji: "4")
    }
}
