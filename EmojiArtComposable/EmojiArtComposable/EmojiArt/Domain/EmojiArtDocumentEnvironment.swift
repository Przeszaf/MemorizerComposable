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
    var imageClient: ImageClient
    var mainQueue: DispatchQueue
}

struct ImageClient {
    var fetchFromURL: (URL) -> Effect<UIImage?, Never>
    
    struct ImageClientFetchId: Hashable {}
}

extension ImageClient {
    static let live = Self(
        fetchFromURL: { url in
            return Effect<UIImage?, Never>.future { callback in
                DispatchQueue.global(qos: .userInitiated).async {
                    let imageData = try? Data(contentsOf: url)
                    print("Fetched image")
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
