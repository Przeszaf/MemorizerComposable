//
//  EmojiArtView.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import ComposableArchitecture
import SwiftUI

struct EmojiArtDocumentView: View {
    let defaultEmojiFontSize: CGFloat = 40

    let store: Store<EmojiArtDocumentState, EmojiArtDocumentAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 0) {
                EmojiArtDocumentBodyView(store: store)
                EmojiArtDocumentPaletteView(viewStore: viewStore)
                    .font(.system(size: defaultEmojiFontSize))
            }
        }
    }
}

struct EmojiArtDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentBuilder().build()
    }
}
