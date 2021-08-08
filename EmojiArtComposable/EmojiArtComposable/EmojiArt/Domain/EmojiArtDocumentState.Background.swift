//
//  EmojiArtState.Background.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import Foundation

extension EmojiArtDocumentState {
    enum Background: Equatable {
        case blank
        case url(URL)
        case imageData(Data)

        var url: URL? {
            switch self {
            case let .url(url): return url
            default: return nil
            }
        }

        var imageData: Data? {
            switch self {
            case let .imageData(data): return data
            default: return nil
            }
        }
    } 
}
