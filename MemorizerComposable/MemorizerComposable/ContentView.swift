//
//  ContentView.swift
//  MemorizerComposable
//
//  Created by Przemyslaw Szafulski on 21/07/2021.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷", "🧟‍♂️", "🍬","🧙‍♂️", "🍫", "🥧", "🥦", "🐲", "🕸", "🧚"]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                ForEach(emojis, id: \.self) { (emoji) in
                    CardView(emoji: emoji).aspectRatio(2/3, contentMode: .fit)
                }
            }
            Spacer()
        }.padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
