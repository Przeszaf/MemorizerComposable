//
//  EmojiArtAction.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import UIKit

enum EmojiArtDocumentAction: Equatable {
    case addEmoji(emoji: EmojiArtDocumentState.Emoji)
    case addBackground(background: EmojiArtDocumentState.Background)
    case moveEmoji(emoji: EmojiArtDocumentState.Emoji, offset: CGSize)
    case scaleEmoji(emoji: EmojiArtDocumentState.Emoji, scale: CGFloat)
    case setBackground(image: UIImage?)
}
