//
//  EmojiArtState.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 04/08/2021.
//

import UIKit

struct EmojiArtDocumentState: Equatable, Codable {
    var background = Background.blank
    var emojis = [Emoji]()
    var backgroundImage: UIImage?
    var backgroundImageFetchStatus = BackgroundImageFetchStatus.idle
    
    init(jsonData: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: jsonData)
    }
    
    init() {
        
    }
    
    enum BackgroundImageFetchStatus: Equatable {
        case idle
        case fetching
    }
    
    struct Emoji: Equatable, Identifiable, Hashable, Codable {
        
        static var emojiId = 0
        
        let text: String
        var x: Int // offset from the centre
        var y: Int // offset from the centre
        var size: Int
        let id: Int
        
        init(text: String, x: Int, y: Int, size: Int) {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = Emoji.emojiId
            Emoji.emojiId += 1
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case background, emojis
    }
    
    func json() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
