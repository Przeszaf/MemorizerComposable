//
//  EmojiArtDocumentBodyEnvironment.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 08/08/2021.
//

import Combine
import ComposableArchitecture
import UIKit

struct EmojiArtDocumentBodyEnvironment {
    var imageClient: EmojiArtDocumentBodyImageClient
    var mainQueue: DispatchQueue
}
