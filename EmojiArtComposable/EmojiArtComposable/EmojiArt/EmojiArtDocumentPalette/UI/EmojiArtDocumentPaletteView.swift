//
//  EmojiArtDocumentPaletteView.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import ComposableArchitecture
import SwiftUI

struct EmojiArtDocumentPaletteView: View {
    let emojis = "😀😅😂😇🥰😉🙃😎🥳😡🤯🥶🤥😴🙄👿😷🤧🤡🍏🍎🥒🍞🥨🥓🍔🍟🍕🍰🍿☕️"

    @ObservedObject
    var viewStore: ViewStore<EmojiArtDocumentState, EmojiArtDocumentAction>

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.map(String.init), id: \.self) { emoji in
                    Text(emoji)
                        .onDrag { NSItemProvider(object: emoji as NSString) }
                }
            }
        }
    }
}

struct EmojiArtDocumentPaletteView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentPaletteView(viewStore: ViewStore(EmojiArtDocumentBuilder().getStore()))
    }
}
