//
//  EmojiArtComposableApp.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import SwiftUI

@main
struct EmojiArtComposableApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentBuilder().build()
        }
    }
}
