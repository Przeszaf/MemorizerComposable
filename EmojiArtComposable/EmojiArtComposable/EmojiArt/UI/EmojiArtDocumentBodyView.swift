//
//  EmojiArtDocumentBodyView.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import ComposableArchitecture
import SwiftUI

struct EmojiArtDocumentBodyView: View {
    @ObservedObject
    var viewStore: ViewStore<EmojiArtDocumentState, EmojiArtDocumentAction>

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.yellow
                ForEach(viewStore.emojis) { emoji in
                    Text(emoji.text)
                        .font(.system(size: fontSize(for: emoji)))
                        .position(position(for: emoji, in: geometry))
                }
            }.onDrop(of: [.plainText], isTargeted: nil) { providers, location in
                drop(providers: providers, location: location, in: geometry)
            }
        }
    }

    private func drop(providers: [NSItemProvider], location: CGPoint,
                      in geometry: GeometryProxy) -> Bool {
        return providers.loadObjects(ofType: String.self) { string in
            if let emojiChar = string.first, emojiChar.isEmoji {
                let location = convertToEmojiCoordinates(location, in: geometry)
                let emojiToAdd = EmojiArtDocumentState.Emoji(
                    text: String(emojiChar),
                    x: location.x,
                    y: location.y,
                    size: 40
                )
                viewStore.send(.addEmoji(emoji: emojiToAdd))
            }
        }
    }

    private func fontSize(for emoji: EmojiArtDocumentState.Emoji) -> CGFloat {
        CGFloat(emoji.size)
    }

    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int),
                                             in geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(x: center.x + CGFloat(location.x), y: center.y + CGFloat(location.y))
    }

    private func convertToEmojiCoordinates(_ location: CGPoint,
                                           in geometry: GeometryProxy) -> (x: Int, y: Int) {
        let center = geometry.frame(in: .local).center
        let location = CGPoint(x: location.x - center.x, y: location.y - center.y)
        return (Int(location.x), Int(location.y))
    }

    private func position(for emoji: EmojiArtDocumentState.Emoji,
                          in geometry: GeometryProxy) -> CGPoint {
        convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry)
    }
}

struct EmojiArtDocumentBodyView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentBodyView(viewStore: ViewStore(EmojiArtDocumentBuilder().getStore()))
    }
}
