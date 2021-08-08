//
//  EmojiArtDocumentSaver.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 08/08/2021.
//

import ComposableArchitecture

struct EmojiArtDocumentSaver {
    static let autosaveFileName = "Autosaved.emojiart"
    var save: (Data, String) -> Void
}

extension EmojiArtDocumentSaver {
    static let live = Self(
        save: { data, fileName in
            print("JSON Saved: \(String(data: data, encoding: .utf8) ?? "nil")")
            let documentDirectory = FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).first
            let url = documentDirectory?.appendingPathComponent(fileName)
            if let url = url {
                try? data.write(to: url)
            }
        }
    )
}
