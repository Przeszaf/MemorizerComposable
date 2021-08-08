//
//  EmojiArtEnvironment.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import Combine
import ComposableArchitecture
import UIKit

struct EmojiArtDocumentEnvironment {
    var documentSaver: EmojiArtDocumentSaver
    var timerScheduler: DispatchQueue
}
