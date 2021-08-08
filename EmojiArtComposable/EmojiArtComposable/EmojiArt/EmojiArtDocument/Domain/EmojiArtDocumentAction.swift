//
//  EmojiArtAction.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import UIKit

enum EmojiArtDocumentAction: Equatable {
    case bodyAction(EmojiArtDocumentBodyAction)
    case onAppear
}
