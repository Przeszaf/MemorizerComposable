//
//  UtilityViews.swift
//  EmojiArtComposable
//
//  Created by Przemyslaw Szafulski on 08/08/2021.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage)
        }
    }
}
