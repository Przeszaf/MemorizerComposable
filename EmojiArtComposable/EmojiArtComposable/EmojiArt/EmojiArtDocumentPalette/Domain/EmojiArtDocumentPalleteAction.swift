//
//  EmojiArtDocumentPalleteAction.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 18/09/2021.
//

import Foundation

enum EmojiArtDocumentPalleteAction: Equatable {
    case getPallete(index: Int)
    case removePallete(index: Int)
    case insertPallete(pallete: EmojiArtDocumentPalleteState.Pallete, index: Int)
}
