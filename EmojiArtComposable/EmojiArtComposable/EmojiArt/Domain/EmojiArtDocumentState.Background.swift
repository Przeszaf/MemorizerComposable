//
//  EmojiArtState.Background.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import Foundation

extension EmojiArtDocumentState {
    enum Background: Equatable, Codable {
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

        enum CodingKeys: String, CodingKey {
            case url
            case imageData
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case let .url(url):
                try container.encode(url, forKey: .url)
            case let .imageData(data):
                try container.encode(data, forKey: .imageData)
            case .blank:
                break
            }
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let url = try? container.decode(URL.self, forKey: .url) {
                self = .url(url)
            } else if let imageData = try? container.decode(Data.self, forKey: .imageData) {
                self = .imageData(imageData)
            } else {
                self = .blank
            }
        }
    }
}
