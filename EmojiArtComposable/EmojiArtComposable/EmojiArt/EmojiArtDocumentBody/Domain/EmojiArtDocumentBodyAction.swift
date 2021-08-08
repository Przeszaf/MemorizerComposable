//
//  EmojiArtDocumentBodyAction.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 08/08/2021.
//

import UIKit

enum EmojiArtDocumentBodyAction: Equatable {
    case addEmoji(emoji: EmojiArtDocumentBodyState.Emoji)
    case setBackground(background: EmojiArtDocumentBodyState.Background)
    case moveEmoji(emoji: EmojiArtDocumentBodyState.Emoji, offset: CGSize)
    case scaleEmoji(emoji: EmojiArtDocumentBodyState.Emoji, scale: CGFloat)
    case setBackgroundImage(image: UIImage?)
    case tryAutosaving
}
