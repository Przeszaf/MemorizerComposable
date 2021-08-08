//
//  EmojiArtDocumentImageClient.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 08/08/2021.
//

import ComposableArchitecture
import Combine
import UIKit

struct EmojiArtDocumentBodyImageClient {
    var fetchFromURL: (URL) -> Effect<UIImage?, Never>
    
    struct ImageClientFetchId: Hashable {}
}

extension EmojiArtDocumentBodyImageClient {
    static let live = Self(
        fetchFromURL: { url in
            return Effect<UIImage?, Never>.future { callback in
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData = try? Data(contentsOf: url)
                    if let imageData = imageData {
                        callback(.success(UIImage(data: imageData)))
                    } else {
                        callback(.success(nil))
                    }
                }
            }
        }
    )
}
